#!/bin/bash
############################################################
# Claude Code Model Switcher (ccm)
# ---------------------------------------------------------
# Quickly switch between different AI models for Claude Code
# Supports: Claude, Deepseek, GLM4.6, KIMI, Qwen, etc.
# Version: 3.0.0
# License: MIT
############################################################

# Color definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Color control for account management output
NO_COLOR=false

set_no_color() {
    if [[ "$NO_COLOR" == "true" ]]; then
        RED='' GREEN='' YELLOW='' BLUE='' NC=''
    fi
}

# Config file paths
CONFIG_FILE="$HOME/.ccm_config"
ACCOUNTS_FILE="$HOME/.ccm_accounts"
KEYCHAIN_SERVICE="${CCM_KEYCHAIN_SERVICE:-Claude Code-credentials}"

# Load config: environment variables take priority, config file supplements
load_config() {
    # Create config file if not exists
    if [[ ! -f "$CONFIG_FILE" ]]; then
        create_default_config
        echo -e "${YELLOW}Config created: $CONFIG_FILE${NC}" >&2
        echo -e "${YELLOW}Edit the file to add your API keys${NC}" >&2
    fi

    # Smart load: only read keys from config if env var is not set
    local temp_file=$(mktemp)
    while IFS= read -r raw || [[ -n "$raw" ]]; do
        raw=${raw%$'\r'}
        [[ "$raw" =~ ^[[:space:]]*# ]] && continue
        [[ -z "$raw" ]] && continue
        local line="${raw%%#*}"
        line=$(echo "$line" | sed -E 's/^[[:space:]]*//; s/[[:space:]]*$//')
        [[ -z "$line" ]] && continue

        if [[ "$line" =~ ^[[:space:]]*(export[[:space:]]+)?([A-Za-z_][A-Za-z0-9_]*)[[:space:]]*=(.*)$ ]]; then
            local key="${BASH_REMATCH[2]}"
            local value="${BASH_REMATCH[3]}"
            value=$(echo "$value" | sed -E 's/^[[:space:]]*//; s/[[:space:]]*$//')
            local env_value="${!key}"
            local lower_env_value=$(printf '%s' "$env_value" | tr '[:upper:]' '[:lower:]')
            local is_placeholder=false
            if [[ "$lower_env_value" == *"your"* && "$lower_env_value" == *"api"* && "$lower_env_value" == *"key"* ]]; then
                is_placeholder=true
            fi
            if [[ -n "$key" && ( -z "$env_value" || "$is_placeholder" == "true" ) ]]; then
                echo "export $key=$value" >> "$temp_file"
            fi
        fi
    done < "$CONFIG_FILE"

    if [[ -s "$temp_file" ]]; then source "$temp_file"; fi
    rm -f "$temp_file"
}

# Create default config file
create_default_config() {
    cat > "$CONFIG_FILE" << 'EOF'
# CCM Configuration File
# Replace with your actual API keys
# Note: Environment variables take priority over this file

# Deepseek
DEEPSEEK_API_KEY=sk-your-deepseek-api-key

# GLM4.6 (Zhipu AI)
GLM_API_KEY=your-glm-api-key

# KIMI for Coding (Moonshot AI)
KIMI_API_KEY=your-kimi-api-key

# LongCat (Meituan)
LONGCAT_API_KEY=your-longcat-api-key

# MiniMax M2
MINIMAX_API_KEY=your-minimax-api-key

# Doubao Seed-Code (ByteDance)
ARK_API_KEY=your-ark-api-key

# Qwen (Alibaba DashScope)
QWEN_API_KEY=your-qwen-api-key

# Claude (if using API key instead of Pro subscription)
CLAUDE_API_KEY=your-claude-api-key

# Model ID overrides (optional)
DEEPSEEK_MODEL=deepseek-chat
DEEPSEEK_SMALL_FAST_MODEL=deepseek-chat
KIMI_MODEL=kimi-for-coding
KIMI_SMALL_FAST_MODEL=kimi-for-coding
KIMI_CN_MODEL=kimi-k2-thinking
KIMI_CN_SMALL_FAST_MODEL=kimi-k2-thinking
QWEN_MODEL=qwen3-max
QWEN_SMALL_FAST_MODEL=qwen3-next-80b-a3b-instruct
GLM_MODEL=glm-4.6
GLM_SMALL_FAST_MODEL=glm-4.5-air
CLAUDE_MODEL=claude-sonnet-4-5-20250929
CLAUDE_SMALL_FAST_MODEL=claude-sonnet-4-5-20250929
OPUS_MODEL=claude-opus-4-5-20251101
OPUS_SMALL_FAST_MODEL=claude-sonnet-4-5-20250929
HAIKU_MODEL=claude-haiku-4-5
HAIKU_SMALL_FAST_MODEL=claude-haiku-4-5
LONGCAT_MODEL=LongCat-Flash-Thinking
LONGCAT_SMALL_FAST_MODEL=LongCat-Flash-Chat
MINIMAX_MODEL=MiniMax-M2
MINIMAX_SMALL_FAST_MODEL=MiniMax-M2
SEED_MODEL=doubao-seed-code-preview-latest
SEED_SMALL_FAST_MODEL=doubao-seed-code-preview-latest

EOF
}

# Check if value is effectively set (non-empty and not placeholder)
is_effectively_set() {
    local v="$1"
    [[ -z "$v" ]] && return 1
    local lower=$(printf '%s' "$v" | tr '[:upper:]' '[:lower:]')
    [[ "$lower" == *your-*-api-key ]] && return 1
    return 0
}

# Mask token for display
mask_token() {
    local t="$1" n=${#1}
    [[ -z "$t" ]] && echo "[Not Set]" && return
    (( n <= 8 )) && echo "[Set] ****" || echo "[Set] ${t:0:4}...${t:n-4:4}"
}

mask_presence() {
    local v_val="${!1}"
    is_effectively_set "$v_val" && echo "[Set]" || echo "[Not Set]"
}

# ============================================
# Claude Pro Account Management
# ============================================

# Read credentials from macOS Keychain
read_keychain_credentials() {
    local -a services=("$KEYCHAIN_SERVICE" "Claude Code - credentials" "Claude Code" "claude" "claude.ai")
    for svc in "${services[@]}"; do
        local credentials=$(security find-generic-password -s "$svc" -w 2>/dev/null)
        if [[ $? -eq 0 && -n "$credentials" ]]; then
            KEYCHAIN_SERVICE="$svc"
            echo "$credentials"
            return 0
        fi
    done
    return 1
}

# Write credentials to macOS Keychain
write_keychain_credentials() {
    local credentials="$1"
    security delete-generic-password -s "$KEYCHAIN_SERVICE" >/dev/null 2>&1
    security add-generic-password -a "$USER" -s "$KEYCHAIN_SERVICE" -w "$credentials" >/dev/null 2>&1
    local result=$?
    if [[ $result -eq 0 ]]; then
        echo -e "${BLUE}Credentials written to Keychain${NC}" >&2
    else
        echo -e "${RED}Failed to write credentials to Keychain (error: $result)${NC}" >&2
    fi
    return $result
}

# Initialize accounts file
init_accounts_file() {
    if [[ ! -f "$ACCOUNTS_FILE" ]]; then
        echo "{}" > "$ACCOUNTS_FILE"
        chmod 600 "$ACCOUNTS_FILE"
    fi
}

# Save current account
save_account() {
    [[ "$NO_COLOR" == "true" ]] && set_no_color
    local account_name="$1"

    if [[ -z "$account_name" ]]; then
        echo -e "${RED}Account name required${NC}" >&2
        echo -e "${YELLOW}Usage: ccm save-account <name>${NC}" >&2
        return 1
    fi

    local credentials=$(read_keychain_credentials)
    if [[ -z "$credentials" ]]; then
        echo -e "${RED}No credentials found in Keychain${NC}" >&2
        echo -e "${YELLOW}Please login to Claude Code first${NC}" >&2
        return 1
    fi

    init_accounts_file
    local encoded_creds=$(echo "$credentials" | base64)

    if [[ "$(cat "$ACCOUNTS_FILE")" == "{}" || ! -s "$ACCOUNTS_FILE" ]]; then
        cat > "$ACCOUNTS_FILE" << EOF
{
  "$account_name": "$encoded_creds"
}
EOF
    elif grep -q "\"$account_name\":" "$ACCOUNTS_FILE"; then
        sed -i '' "s/\"$account_name\": *\"[^\"]*\"/\"$account_name\": \"$encoded_creds\"/" "$ACCOUNTS_FILE"
    else
        local temp_file=$(mktemp)
        sed '$d' "$ACCOUNTS_FILE" > "$temp_file"
        grep -q '"' "$temp_file" && echo "," >> "$temp_file"
        echo "  \"$account_name\": \"$encoded_creds\"" >> "$temp_file"
        echo "}" >> "$temp_file"
        mv "$temp_file" "$ACCOUNTS_FILE"
    fi
    chmod 600 "$ACCOUNTS_FILE"

    local subscription_type=$(echo "$credentials" | grep -o '"subscriptionType":"[^"]*"' | cut -d'"' -f4)
    echo -e "${GREEN}Account saved: $account_name${NC}"
    echo "   Subscription: ${subscription_type:-Unknown}"
}

# Switch to specified account
switch_account() {
    [[ "$NO_COLOR" == "true" ]] && set_no_color
    local account_name="$1"

    if [[ -z "$account_name" ]]; then
        echo -e "${RED}Account name required${NC}" >&2
        echo -e "${YELLOW}Usage: ccm switch-account <name>${NC}" >&2
        return 1
    fi

    if [[ ! -f "$ACCOUNTS_FILE" ]]; then
        echo -e "${RED}No accounts found${NC}" >&2
        echo -e "${YELLOW}Save an account first with: ccm save-account <name>${NC}" >&2
        return 1
    fi

    local encoded_creds=$(grep -o "\"$account_name\": *\"[^\"]*\"" "$ACCOUNTS_FILE" | cut -d'"' -f4)
    if [[ -z "$encoded_creds" ]]; then
        echo -e "${RED}Account not found: $account_name${NC}" >&2
        echo -e "${YELLOW}Use 'ccm list-accounts' to see available accounts${NC}" >&2
        return 1
    fi

    local credentials=$(echo "$encoded_creds" | base64 -d)
    if write_keychain_credentials "$credentials"; then
        echo -e "${GREEN}Switched to account: $account_name${NC}"
        echo -e "${YELLOW}Please restart Claude Code for changes to take effect${NC}"
    else
        echo -e "${RED}Failed to switch account${NC}" >&2
        return 1
    fi
}

# List all saved accounts
list_accounts() {
    if [[ ! -f "$ACCOUNTS_FILE" ]]; then
        echo -e "${YELLOW}No accounts saved${NC}"
        echo -e "${YELLOW}Use 'ccm save-account <name>' to save an account${NC}"
        return 0
    fi

    echo -e "${BLUE}Saved accounts:${NC}"
    local current_creds=$(read_keychain_credentials)

    grep --color=never -o '"[^"]*": *"[^"]*"' "$ACCOUNTS_FILE" | while IFS=': ' read -r name encoded; do
        name=$(echo "$name" | tr -d '"')
        encoded=$(echo "$encoded" | tr -d '"')
        local creds=$(echo "$encoded" | base64 -d 2>/dev/null)
        local subscription=$(echo "$creds" | grep -o '"subscriptionType":"[^"]*"' | cut -d'"' -f4)
        local expires=$(echo "$creds" | grep -o '"expiresAt":[0-9]*' | cut -d':' -f2)
        local is_current=""
        [[ "$creds" == "$current_creds" ]] && is_current=" ${GREEN}(active)${NC}"
        local expires_str=""
        [[ -n "$expires" ]] && expires_str=$(date -r $((expires / 1000)) "+%Y-%m-%d %H:%M" 2>/dev/null)
        echo -e "   - ${YELLOW}$name${NC} (${subscription:-Unknown}${expires_str:+, expires: $expires_str})$is_current"
    done
}

# Delete saved account
delete_account() {
    local account_name="$1"
    if [[ -z "$account_name" ]]; then
        echo -e "${RED}Account name required${NC}" >&2
        echo -e "${YELLOW}Usage: ccm delete-account <name>${NC}" >&2
        return 1
    fi

    if [[ ! -f "$ACCOUNTS_FILE" ]]; then
        echo -e "${RED}No accounts found${NC}" >&2
        return 1
    fi

    if ! grep -q "\"$account_name\":" "$ACCOUNTS_FILE"; then
        echo -e "${RED}Account not found: $account_name${NC}" >&2
        return 1
    fi

    local temp_file=$(mktemp)
    grep -v "\"$account_name\":" "$ACCOUNTS_FILE" > "$temp_file"
    sed -i '' 's/,\s*}/}/g' "$temp_file" 2>/dev/null
    mv "$temp_file" "$ACCOUNTS_FILE"
    chmod 600 "$ACCOUNTS_FILE"
    echo -e "${GREEN}Account deleted: $account_name${NC}"
}

# Show current account info
get_current_account() {
    local credentials=$(read_keychain_credentials)
    if [[ -z "$credentials" ]]; then
        echo -e "${YELLOW}No current account${NC}"
        echo -e "${YELLOW}Please login or switch to an account${NC}"
        return 1
    fi

    local subscription=$(echo "$credentials" | grep -o '"subscriptionType":"[^"]*"' | cut -d'"' -f4)
    local expires=$(echo "$credentials" | grep -o '"expiresAt":[0-9]*' | cut -d':' -f2)
    local access_token=$(echo "$credentials" | grep -o '"accessToken":"[^"]*"' | cut -d'"' -f4)
    local expires_str=""
    [[ -n "$expires" ]] && expires_str=$(date -r $((expires / 1000)) "+%Y-%m-%d %H:%M" 2>/dev/null)

    local account_name="Unknown"
    if [[ -f "$ACCOUNTS_FILE" ]]; then
        while IFS=': ' read -r name encoded; do
            name=$(echo "$name" | tr -d '"')
            encoded=$(echo "$encoded" | tr -d '"')
            local saved_creds=$(echo "$encoded" | base64 -d 2>/dev/null)
            if [[ "$saved_creds" == "$credentials" ]]; then
                account_name="$name"
                break
            fi
        done < <(grep --color=never -o '"[^"]*": *"[^"]*"' "$ACCOUNTS_FILE")
    fi

    echo -e "${BLUE}Current account info:${NC}"
    echo "   Account: ${account_name}"
    echo "   Subscription: ${subscription:-Unknown}"
    [[ -n "$expires_str" ]] && echo "   Token expires: ${expires_str}"
    echo -n "   Access token: "; mask_token "$access_token"
}

# Show current status (masked)
show_status() {
    echo -e "${BLUE}Current model config:${NC}"
    echo "   BASE_URL: ${ANTHROPIC_BASE_URL:-'Default (Anthropic)'}"
    echo -n "   AUTH_TOKEN: "; mask_token "${ANTHROPIC_AUTH_TOKEN}"
    echo "   MODEL: ${ANTHROPIC_MODEL:-'Not Set'}"
    echo "   SMALL_MODEL: ${ANTHROPIC_SMALL_FAST_MODEL:-'Not Set'}"
    echo ""
    echo -e "${BLUE}API keys status:${NC}"
    echo "   DEEPSEEK_API_KEY: $(mask_presence DEEPSEEK_API_KEY)"
    echo "   GLM_API_KEY: $(mask_presence GLM_API_KEY)"
    echo "   KIMI_API_KEY: $(mask_presence KIMI_API_KEY)"
    echo "   LONGCAT_API_KEY: $(mask_presence LONGCAT_API_KEY)"
    echo "   MINIMAX_API_KEY: $(mask_presence MINIMAX_API_KEY)"
    echo "   ARK_API_KEY: $(mask_presence ARK_API_KEY)"
    echo "   QWEN_API_KEY: $(mask_presence QWEN_API_KEY)"
}

# Clean environment variables
clean_env() {
    unset ANTHROPIC_BASE_URL ANTHROPIC_API_URL ANTHROPIC_AUTH_TOKEN ANTHROPIC_API_KEY
    unset ANTHROPIC_MODEL ANTHROPIC_SMALL_FAST_MODEL API_TIMEOUT_MS CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC
}

# Output export statements only (for eval)
emit_env_exports() {
    local target="$1"
    load_config || return 1

    local prelude="unset ANTHROPIC_BASE_URL ANTHROPIC_API_URL ANTHROPIC_AUTH_TOKEN ANTHROPIC_API_KEY ANTHROPIC_MODEL ANTHROPIC_SMALL_FAST_MODEL API_TIMEOUT_MS CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC"

    case "$target" in
        "deepseek"|"ds")
            if ! is_effectively_set "$DEEPSEEK_API_KEY"; then
                echo -e "${RED}Please configure DEEPSEEK_API_KEY${NC}" >&2
                return 1
            fi
            echo "$prelude"
            echo "export API_TIMEOUT_MS='600000'"
            echo "export CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC='1'"
            echo "export ANTHROPIC_BASE_URL='https://api.deepseek.com/anthropic'"
            echo "export ANTHROPIC_API_URL='https://api.deepseek.com/anthropic'"
            echo "if [ -z \"\${DEEPSEEK_API_KEY}\" ] && [ -f \"\$HOME/.ccm_config\" ]; then . \"\$HOME/.ccm_config\" >/dev/null 2>&1; fi"
            echo "export ANTHROPIC_AUTH_TOKEN=\"\${DEEPSEEK_API_KEY}\""
            echo "export ANTHROPIC_MODEL='${DEEPSEEK_MODEL:-deepseek-chat}'"
            echo "export ANTHROPIC_SMALL_FAST_MODEL='${DEEPSEEK_SMALL_FAST_MODEL:-deepseek-chat}'"
            ;;
        "kimi"|"kimi2")
            if ! is_effectively_set "$KIMI_API_KEY"; then
                echo -e "${RED}Please configure KIMI_API_KEY${NC}" >&2
                return 1
            fi
            echo "$prelude"
            echo "export API_TIMEOUT_MS='600000'"
            echo "export CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC='1'"
            echo "export ANTHROPIC_BASE_URL='https://api.kimi.com/coding/'"
            echo "export ANTHROPIC_API_URL='https://api.kimi.com/coding/'"
            echo "if [ -z \"\${KIMI_API_KEY}\" ] && [ -f \"\$HOME/.ccm_config\" ]; then . \"\$HOME/.ccm_config\" >/dev/null 2>&1; fi"
            echo "export ANTHROPIC_AUTH_TOKEN=\"\${KIMI_API_KEY}\""
            echo "export ANTHROPIC_MODEL='${KIMI_MODEL:-kimi-for-coding}'"
            echo "export ANTHROPIC_SMALL_FAST_MODEL='${KIMI_SMALL_FAST_MODEL:-kimi-for-coding}'"
            ;;
        "kimi-cn")
            if ! is_effectively_set "$KIMI_API_KEY"; then
                echo -e "${RED}Please configure KIMI_API_KEY${NC}" >&2
                return 1
            fi
            echo "$prelude"
            echo "export API_TIMEOUT_MS='600000'"
            echo "export CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC='1'"
            echo "export ANTHROPIC_BASE_URL='https://api.moonshot.cn/anthropic'"
            echo "export ANTHROPIC_API_URL='https://api.moonshot.cn/anthropic'"
            echo "if [ -z \"\${KIMI_API_KEY}\" ] && [ -f \"\$HOME/.ccm_config\" ]; then . \"\$HOME/.ccm_config\" >/dev/null 2>&1; fi"
            echo "export ANTHROPIC_AUTH_TOKEN=\"\${KIMI_API_KEY}\""
            echo "export ANTHROPIC_MODEL='${KIMI_CN_MODEL:-kimi-k2-thinking}'"
            echo "export ANTHROPIC_SMALL_FAST_MODEL='${KIMI_CN_SMALL_FAST_MODEL:-kimi-k2-thinking}'"
            ;;
        "qwen")
            if ! is_effectively_set "$QWEN_API_KEY"; then
                echo -e "${RED}Please configure QWEN_API_KEY${NC}" >&2
                return 1
            fi
            echo "$prelude"
            echo "export API_TIMEOUT_MS='600000'"
            echo "export CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC='1'"
            echo "export ANTHROPIC_BASE_URL='https://dashscope.aliyuncs.com/api/v2/apps/claude-code-proxy'"
            echo "export ANTHROPIC_API_URL='https://dashscope.aliyuncs.com/api/v2/apps/claude-code-proxy'"
            echo "if [ -z \"\${QWEN_API_KEY}\" ] && [ -f \"\$HOME/.ccm_config\" ]; then . \"\$HOME/.ccm_config\" >/dev/null 2>&1; fi"
            echo "export ANTHROPIC_AUTH_TOKEN=\"\${QWEN_API_KEY}\""
            echo "export ANTHROPIC_MODEL='${QWEN_MODEL:-qwen3-max}'"
            echo "export ANTHROPIC_SMALL_FAST_MODEL='${QWEN_SMALL_FAST_MODEL:-qwen3-next-80b-a3b-instruct}'"
            ;;
        "glm"|"glm4"|"glm4.6")
            if ! is_effectively_set "$GLM_API_KEY"; then
                echo -e "${RED}Please configure GLM_API_KEY${NC}" >&2
                return 1
            fi
            echo "$prelude"
            echo "export API_TIMEOUT_MS='600000'"
            echo "export CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC='1'"
            echo "export ANTHROPIC_BASE_URL='https://open.bigmodel.cn/api/anthropic'"
            echo "export ANTHROPIC_API_URL='https://open.bigmodel.cn/api/anthropic'"
            echo "if [ -z \"\${GLM_API_KEY}\" ] && [ -f \"\$HOME/.ccm_config\" ]; then . \"\$HOME/.ccm_config\" >/dev/null 2>&1; fi"
            echo "export ANTHROPIC_AUTH_TOKEN=\"\${GLM_API_KEY}\""
            echo "export ANTHROPIC_MODEL='${GLM_MODEL:-glm-4.6}'"
            echo "export ANTHROPIC_SMALL_FAST_MODEL='${GLM_SMALL_FAST_MODEL:-glm-4.5-air}'"
            ;;
        "longcat"|"lc")
            [[ ! -f "$HOME/.ccm_config" ]] || . "$HOME/.ccm_config" >/dev/null 2>&1
            if ! is_effectively_set "$LONGCAT_API_KEY"; then
                echo -e "${RED}Please configure LONGCAT_API_KEY${NC}" >&2
                return 1
            fi
            echo "$prelude"
            echo "export API_TIMEOUT_MS='600000'"
            echo "export CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC='1'"
            echo "export ANTHROPIC_BASE_URL='https://api.longcat.chat/anthropic'"
            echo "export ANTHROPIC_API_URL='https://api.longcat.chat/anthropic'"
            echo "if [ -z \"\${LONGCAT_API_KEY}\" ] && [ -f \"\$HOME/.ccm_config\" ]; then . \"\$HOME/.ccm_config\" >/dev/null 2>&1; fi"
            echo "export ANTHROPIC_AUTH_TOKEN=\"\${LONGCAT_API_KEY}\""
            echo "export ANTHROPIC_MODEL='${LONGCAT_MODEL:-LongCat-Flash-Thinking}'"
            echo "export ANTHROPIC_SMALL_FAST_MODEL='${LONGCAT_SMALL_FAST_MODEL:-LongCat-Flash-Chat}'"
            ;;
        "minimax"|"mm")
            if ! is_effectively_set "$MINIMAX_API_KEY"; then
                echo -e "${RED}Please configure MINIMAX_API_KEY${NC}" >&2
                return 1
            fi
            echo "$prelude"
            echo "export API_TIMEOUT_MS='600000'"
            echo "export CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC='1'"
            echo "export ANTHROPIC_BASE_URL='https://api.minimax.io/anthropic'"
            echo "export ANTHROPIC_API_URL='https://api.minimax.io/anthropic'"
            echo "if [ -z \"\${MINIMAX_API_KEY}\" ] && [ -f \"\$HOME/.ccm_config\" ]; then . \"\$HOME/.ccm_config\" >/dev/null 2>&1; fi"
            echo "export ANTHROPIC_AUTH_TOKEN=\"\${MINIMAX_API_KEY}\""
            echo "export ANTHROPIC_MODEL='${MINIMAX_MODEL:-MiniMax-M2}'"
            echo "export ANTHROPIC_SMALL_FAST_MODEL='${MINIMAX_SMALL_FAST_MODEL:-MiniMax-M2}'"
            ;;
        "seed"|"doubao")
            if ! is_effectively_set "$ARK_API_KEY"; then
                echo -e "${RED}Please configure ARK_API_KEY${NC}" >&2
                return 1
            fi
            echo "$prelude"
            echo "export API_TIMEOUT_MS='3000000'"
            echo "export CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC='1'"
            echo "export ANTHROPIC_BASE_URL='https://ark.cn-beijing.volces.com/api/coding'"
            echo "export ANTHROPIC_API_URL='https://ark.cn-beijing.volces.com/api/coding'"
            echo "if [ -z \"\${ARK_API_KEY}\" ] && [ -f \"\$HOME/.ccm_config\" ]; then . \"\$HOME/.ccm_config\" >/dev/null 2>&1; fi"
            echo "export ANTHROPIC_AUTH_TOKEN=\"\${ARK_API_KEY}\""
            echo "export ANTHROPIC_MODEL='${SEED_MODEL:-doubao-seed-code-preview-latest}'"
            echo "export ANTHROPIC_SMALL_FAST_MODEL='${SEED_SMALL_FAST_MODEL:-doubao-seed-code-preview-latest}'"
            ;;
        "claude"|"sonnet"|"s")
            echo "$prelude"
            echo "unset ANTHROPIC_BASE_URL ANTHROPIC_API_URL ANTHROPIC_API_KEY"
            echo "export ANTHROPIC_MODEL='${CLAUDE_MODEL:-claude-sonnet-4-5-20250929}'"
            echo "export ANTHROPIC_SMALL_FAST_MODEL='${CLAUDE_SMALL_FAST_MODEL:-claude-sonnet-4-5-20250929}'"
            ;;
        "opus"|"o")
            echo "$prelude"
            echo "unset ANTHROPIC_BASE_URL ANTHROPIC_API_URL ANTHROPIC_API_KEY"
            echo "export ANTHROPIC_MODEL='${OPUS_MODEL:-claude-opus-4-5-20251101}'"
            echo "export ANTHROPIC_SMALL_FAST_MODEL='${OPUS_SMALL_FAST_MODEL:-claude-sonnet-4-5-20250929}'"
            ;;
        "haiku"|"h")
            echo "$prelude"
            echo "unset ANTHROPIC_BASE_URL ANTHROPIC_API_URL ANTHROPIC_API_KEY"
            echo "export ANTHROPIC_MODEL='${HAIKU_MODEL:-claude-haiku-4-5}'"
            echo "export ANTHROPIC_SMALL_FAST_MODEL='${HAIKU_SMALL_FAST_MODEL:-claude-haiku-4-5}'"
            ;;
        *)
            echo "# Usage: ccm [deepseek|kimi|kimi-cn|qwen|glm|longcat|minimax|seed|claude|opus|haiku]" >&2
            return 1
            ;;
    esac
}

# Edit config file
edit_config() {
    [[ ! -f "$CONFIG_FILE" ]] && create_default_config
    echo -e "${BLUE}Opening config file...${NC}"
    echo -e "${YELLOW}Path: $CONFIG_FILE${NC}"

    if command -v cursor >/dev/null 2>&1; then
        cursor "$CONFIG_FILE" &
    elif command -v code >/dev/null 2>&1; then
        code "$CONFIG_FILE" &
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        open "$CONFIG_FILE"
    elif command -v vim >/dev/null 2>&1; then
        vim "$CONFIG_FILE"
    elif command -v nano >/dev/null 2>&1; then
        nano "$CONFIG_FILE"
    else
        echo -e "${RED}No editor found${NC}"
        echo -e "${YELLOW}Edit manually: $CONFIG_FILE${NC}"
        return 1
    fi
}

# Show help
show_help() {
    echo -e "${BLUE}Claude Code Model Switcher v3.0.0${NC}"
    echo ""
    echo -e "${YELLOW}Usage:${NC} ccm <command> [options]"
    echo ""
    echo -e "${YELLOW}Model Commands:${NC}"
    echo "  deepseek, ds       - Switch to Deepseek"
    echo "  kimi, kimi2        - Switch to KIMI for Coding"
    echo "  kimi-cn            - Switch to KIMI CN (domestic)"
    echo "  seed, doubao       - Switch to Doubao Seed-Code"
    echo "  longcat, lc        - Switch to LongCat"
    echo "  minimax, mm        - Switch to MiniMax M2"
    echo "  qwen               - Switch to Qwen"
    echo "  glm, glm4          - Switch to GLM4.6"
    echo "  claude, sonnet, s  - Switch to Claude Sonnet 4.5"
    echo "  opus, o            - Switch to Claude Opus 4.5"
    echo "  haiku, h           - Switch to Claude Haiku 4.5"
    echo ""
    echo -e "${YELLOW}Account Management:${NC}"
    echo "  save-account <name>     - Save current Claude Pro account"
    echo "  switch-account <name>   - Switch to saved account"
    echo "  list-accounts           - List all saved accounts"
    echo "  delete-account <name>   - Delete saved account"
    echo "  current-account         - Show current account info"
    echo "  claude:account          - Switch account and use Claude Sonnet"
    echo "  opus:account            - Switch account and use Opus"
    echo "  haiku:account           - Switch account and use Haiku"
    echo ""
    echo -e "${YELLOW}Other Commands:${NC}"
    echo "  status, st         - Show current configuration"
    echo "  config, cfg        - Edit config file"
    echo "  help, -h           - Show this help"
    echo ""
    echo -e "${YELLOW}Examples:${NC}"
    echo "  eval \"\$(ccm deepseek)\"           # Apply in current shell"
    echo "  eval \"\$(ccm opus)\"               # Switch to Opus model"
    echo "  ccm save-account work             # Save current account as 'work'"
    echo "  eval \"\$(ccm opus:personal)\"      # Switch account and model"
    echo ""
    echo -e "${YELLOW}Supported Models:${NC}"
    echo "  Deepseek       - deepseek-chat (api.deepseek.com)"
    echo "  KIMI           - kimi-for-coding (api.kimi.com)"
    echo "  KIMI CN        - kimi-k2-thinking (api.moonshot.cn)"
    echo "  Seed-Code      - doubao-seed-code (ark.cn-beijing.volces.com)"
    echo "  LongCat        - LongCat-Flash-Thinking (api.longcat.chat)"
    echo "  MiniMax        - MiniMax-M2 (api.minimax.io)"
    echo "  Qwen           - qwen3-max (dashscope.aliyuncs.com)"
    echo "  GLM4.6         - glm-4.6 (open.bigmodel.cn)"
    echo "  Claude Sonnet  - claude-sonnet-4-5-20250929"
    echo "  Claude Opus    - claude-opus-4-5-20251101"
    echo "  Claude Haiku   - claude-haiku-4-5"
}

# Main function
main() {
    load_config || return 1
    local cmd="${1:-help}"

    # Handle model:account format
    if [[ "$cmd" =~ ^(claude|sonnet|opus|haiku|s|o|h):(.+)$ ]]; then
        local model_type="${BASH_REMATCH[1]}"
        local account_name="${BASH_REMATCH[2]}"
        switch_account "$account_name" >&2 || return 1
        case "$model_type" in
            "claude"|"sonnet"|"s") emit_env_exports claude ;;
            "opus"|"o") emit_env_exports opus ;;
            "haiku"|"h") emit_env_exports haiku ;;
        esac
        return $?
    fi

    case "$cmd" in
        "save-account") shift; save_account "$1" ;;
        "switch-account") shift; switch_account "$1" ;;
        "list-accounts") list_accounts ;;
        "delete-account") shift; delete_account "$1" ;;
        "current-account") get_current_account ;;
        "deepseek"|"ds") emit_env_exports deepseek ;;
        "kimi"|"kimi2") emit_env_exports kimi ;;
        "kimi-cn") emit_env_exports kimi-cn ;;
        "qwen") emit_env_exports qwen ;;
        "longcat"|"lc") emit_env_exports longcat ;;
        "minimax"|"mm") emit_env_exports minimax ;;
        "seed"|"doubao") emit_env_exports seed ;;
        "glm"|"glm4"|"glm4.6") emit_env_exports glm ;;
        "claude"|"sonnet"|"s") emit_env_exports claude ;;
        "opus"|"o") emit_env_exports opus ;;
        "haiku"|"h") emit_env_exports haiku ;;
        "status"|"st") show_status ;;
        "config"|"cfg") edit_config ;;
        "help"|"-h"|"--help") show_help ;;
        *)
            echo -e "${RED}Unknown command: $cmd${NC}" >&2
            show_help >&2
            return 1
            ;;
    esac
}

main "$@"
