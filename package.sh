#!/bin/bash
# Package brainstomer as a skill ZIP for Claude.ai/Desktop

set -e

VERSION="${1:-$(git describe --tags --always 2>/dev/null || echo "dev")}"
OUTPUT="brainstomer-${VERSION}.zip"

echo "Packaging brainstomer ${VERSION}..."

# Create temp directory
TMPDIR=$(mktemp -d)
SKILL_DIR="${TMPDIR}/brainstomer"
mkdir -p "${SKILL_DIR}"

# Copy skill files
cp SKILL.md "${SKILL_DIR}/"
cp -r workflows "${SKILL_DIR}/"
cp -r agents "${SKILL_DIR}/"
cp -r templates "${SKILL_DIR}/" 2>/dev/null || true
cp -r references "${SKILL_DIR}/" 2>/dev/null || true

# Create ZIP
cd "${TMPDIR}"
zip -r "${OUTPUT}" brainstomer

# Move to original directory
cd - > /dev/null
mv "${TMPDIR}/${OUTPUT}" .

# Cleanup
rm -rf "${TMPDIR}"

echo "Created: ${OUTPUT}"
echo ""
echo "To install in Claude.ai/Desktop:"
echo "  1. Go to Customize > Skills"
echo "  2. Click '+' > Upload a skill"
echo "  3. Select ${OUTPUT}"
