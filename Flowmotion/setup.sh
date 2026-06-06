#!/bin/bash
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$DIR"

# Check xcodegen
if ! command -v xcodegen &> /dev/null; then
    echo "⚠️  xcodegen not found. Attempting to install via Homebrew..."
    if ! command -v brew &> /dev/null; then
        echo "❌ Homebrew not found."
        echo ""
        echo "Please install Homebrew first:"
        echo '  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
        echo ""
        echo "Then run this script again."
        exit 1
    fi
    brew install xcodegen
fi

echo "🔨 Generating Flowmotion.xcodeproj..."
xcodegen generate

echo ""
echo "✅ Done! Opening Xcode..."
open Flowmotion.xcodeproj
