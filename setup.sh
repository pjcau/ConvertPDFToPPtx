#!/bin/bash

# Script di setup per PDF to PowerPoint Converter
# Installa le dipendenze necessarie per PyMuPDF

echo "=========================================="
echo "PDF to PPT Converter - Setup"
echo "Installazione dipendenze PyMuPDF"
echo "=========================================="

# Colori per output
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ $1${NC}"
}

# Detecta pip
if command -v pip3 &> /dev/null; then
    PIP_CMD="pip3"
    PYTHON_CMD="python3"
elif command -v pip &> /dev/null; then
    PIP_CMD="pip"
    PYTHON_CMD="python"
else
    print_error "pip non trovato. Installa Python e pip prima di continuare."
    exit 1
fi

print_info "Usando $PIP_CMD e $PYTHON_CMD..."

# Installa le dipendenze
DEPENDENCIES=("PyMuPDF" "python-pptx" "Pillow")

for dep in "${DEPENDENCIES[@]}"; do
    print_info "Installando $dep..."
    $PIP_CMD install "$dep"
    if [ $? -eq 0 ]; then
        print_success "$dep installato correttamente"
    else
        print_error "Errore nell'installazione di $dep"
        exit 1
    fi
done

# Test dell'installazione
print_info "Test delle dipendenze..."
$PYTHON_CMD -c "
import sys
try:
    import fitz
    print('✓ PyMuPDF: OK')
except ImportError as e:
    print('✗ PyMuPDF: ERRORE')
    sys.exit(1)

try:
    from pptx import Presentation
    print('✓ python-pptx: OK')
except ImportError as e:
    print('✗ python-pptx: ERRORE')
    sys.exit(1)

try:
    from PIL import Image
    print('✓ Pillow: OK')
except ImportError as e:
    print('✗ Pillow: ERRORE')
    sys.exit(1)

print('✓ Tutte le dipendenze sono disponibili')
"

if [ $? -eq 0 ]; then
    print_success "Setup completato con successo!"
    echo
    print_info "Ora puoi usare il convertitore con:"
    echo "  $PYTHON_CMD src/pdf_converter.py"
    echo
    print_info "Oppure con parametri personalizzati:"
    echo "  $PYTHON_CMD src/pdf_converter.py input.pdf output.pptx"
else
    print_error "Setup fallito"
    exit 1
fi

echo "=========================================="