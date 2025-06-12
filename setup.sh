#!/bin/bash
# filepath: /Users/pierrejonnycau/Documents/university/thesis_triennal_UTIU/presentation/ConvertPDFToPPtx/setup.sh

# Script di setup per PDF to PowerPoint Converter
# Crea ambiente virtuale e installa le dipendenze necessarie per PyMuPDF

echo "=========================================="
echo "PDF to PPT Converter - Setup"
echo "Creazione ambiente virtuale e installazione dipendenze"
echo "=========================================="

# Colori per output
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
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

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

# Verifica che python3 sia disponibile
if ! command -v python3 &>/dev/null; then
    print_error "python3 non trovato. Installa python3 3 prima di continuare."
    exit 1
fi

print_info "Usando python3: $(python3 --version)"

# Nome dell'ambiente virtuale
VENV_NAME="pdf_converter_env"

# Rimuovi ambiente esistente se presente
if [ -d "$VENV_NAME" ]; then
    print_warning "Ambiente virtuale esistente trovato. Rimuovo..."
    rm -rf "$VENV_NAME"
fi

# Crea nuovo ambiente virtuale
print_info "Creando ambiente virtuale '$VENV_NAME'..."
python3 -m venv "$VENV_NAME"

if [ $? -ne 0 ]; then
    print_error "Errore nella creazione dell'ambiente virtuale"
    exit 1
fi

print_success "Ambiente virtuale creato"

# Attiva l'ambiente virtuale
print_info "Attivando ambiente virtuale..."
source "$VENV_NAME/bin/activate"

if [ $? -ne 0 ]; then
    print_error "Errore nell'attivazione dell'ambiente virtuale"
    exit 1
fi

print_success "Ambiente virtuale attivato"

# Aggiorna pip nell'ambiente virtuale
print_info "Aggiornando pip, setuptools e wheel..."
pip install --upgrade pip setuptools wheel

if [ $? -ne 0 ]; then
    print_error "Errore nell'aggiornamento di pip"
    deactivate
    exit 1
fi

print_success "pip aggiornato"

# Detecta architettura del sistema per PyMuPDF
ARCH=$(uname -m)
print_info "Architettura rilevata: $ARCH"

# Installa PyMuPDF con opzioni specifiche per macOS
print_info "Installando PyMuPDF..."

if [[ "$ARCH" == "arm64" ]]; then
    # Per Apple Silicon (M1/M2)
    print_info "Installazione ottimizzata per Apple Silicon..."
    pip install PyMuPDF --no-cache-dir --force-reinstall
else
    # Per Intel Mac
    pip install PyMuPDF --no-cache-dir
fi

if [ $? -eq 0 ]; then
    print_success "PyMuPDF installato correttamente"
else
    print_error "Errore nell'installazione di PyMuPDF. Provo installazione alternativa..."

    # Prova installazione alternativa
    pip install --pre PyMuPDF --no-cache-dir

    if [ $? -ne 0 ]; then
        print_error "Installazione PyMuPDF fallita completamente."
        echo
        print_info "Possibili soluzioni:"
        echo "1. Installa Homebrew e mupdf-tools: brew install mupdf-tools"
        echo "2. Riprova il setup dopo aver installato mupdf-tools"
        deactivate
        exit 1
    fi
fi

# Installa le altre dipendenze
OTHER_DEPS=("python-pptx" "Pillow")
for dep in "${OTHER_DEPS[@]}"; do
    print_info "Installando $dep..."
    pip install "$dep"
    if [ $? -eq 0 ]; then
        print_success "$dep installato correttamente"
    else
        print_error "Errore nell'installazione di $dep"
        deactivate
        exit 1
    fi
done

# Test dell'installazione
print_info "Test delle dipendenze..."
python3 -c "
import sys
try:
    import fitz
    print('✓ PyMuPDF: OK')
except ImportError as e:
    print('✗ PyMuPDF: ERRORE')
    print(f'Dettagli errore: {e}')
    sys.exit(1)

try:
    from pptx import Presentation
    print('✓ python-pptx: OK')
except ImportError as e:
    print('✗ python-pptx: ERRORE')
    print(f'Dettagli errore: {e}')
    sys.exit(1)

try:
    from PIL import Image
    print('✓ Pillow: OK')
except ImportError as e:
    print('✗ Pillow: ERRORE')
    print(f'Dettagli errore: {e}')
    sys.exit(1)

print('✓ Tutte le dipendenze sono disponibili')
"

if [ $? -eq 0 ]; then
    print_success "Setup completato con successo!"
    echo
    print_info "Ambiente virtuale creato in: $(pwd)/$VENV_NAME"
    print_info "Per usare il convertitore:"
    echo "  1. Attiva l'ambiente: source $VENV_NAME/bin/activate"
    echo "  2. Esegui il convertitore: python3 src/pdf_converter.py"
    echo "  3. Disattiva l'ambiente: deactivate"
    echo
    print_info "Esempi di utilizzo:"
    echo "  python3 src/pdf_converter.py input.pdf output.pptx"
    echo "  python3 src/pdf_converter.py --help"

    # Crea script di attivazione rapida
    cat >activate_env.sh <<'EOF'
#!/bin/bash
echo "Attivando ambiente virtuale PDF Converter..."
source pdf_converter_env/bin/activate
echo "✓ Ambiente attivato. Usa 'deactivate' per uscire."
EOF
    chmod +x activate_env.sh
    print_success "Script di attivazione rapida creato: ./activate_env.sh"
else
    print_error "Setup fallito"
    deactivate
    exit 1
fi

# Deattiva l'ambiente (opzionale, per pulizia)
deactivate

echo "=========================================="
