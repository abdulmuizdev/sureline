#!/bin/bash

# Setup script for secrets configuration
# This script helps developers set up their secrets file from the template

echo "🔐 Setting up secrets configuration..."

# Check if secrets file already exists
if [ -f "lib/core/constants/secrets.dart" ]; then
    echo "⚠️  secrets.dart already exists. Do you want to overwrite it? (y/n)"
    read -r response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
        echo "📝 Overwriting existing secrets file..."
    else
        echo "❌ Setup cancelled. Existing secrets file preserved."
        exit 0
    fi
fi

# Copy template to secrets file
cp lib/core/constants/secrets.template.dart lib/core/constants/secrets.dart

if [ $? -eq 0 ]; then
    echo "✅ Successfully created secrets.dart from template"
    echo ""
    echo "📋 Next steps:"
    echo "1. Open lib/core/constants/secrets.dart"
    echo "2. Replace the placeholder values with your actual API keys:"
        echo "   - FLAGSMITH_API_KEY"
    echo "   - SUPERWALL_API_KEY"
    echo "   - CANNY_PRIVATE_KEY"
    echo "   - CANNY_BOARD_TOKEN"
    echo "   - FACEBOOK_APP_ID"
    echo "   - FACEBOOK_CLIENT_TOKEN"
    echo "   - TIKTOK_CLIENT_KEY"
    echo "   - REVENUECAT_API_KEY"
    echo "   - DEFAULT_USER_EMAIL"
    echo ""
    echo "🔒 The secrets.dart file is already added to .gitignore"
    echo "   so your secrets won't be committed to version control."
else
    echo "❌ Failed to create secrets file. Please check if the template exists."
    exit 1
fi