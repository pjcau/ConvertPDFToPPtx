#!/bin/bash
# filepath: /Users/pierrejonnycau/Documents/university/thesis_triennal_UTIU/presentation/ConvertPDFToPPtx/convert.sh

# Script wrapper per il convertitore PDF to PPT
echo "🔄 Attivando ambiente virtuale..."
source pdf_converter_env/bin/activate

if [ $? -ne 0 ]; then
    echo "❌ Errore nell'attivazione dell'ambiente virtuale"
    echo "Esegui prima: ./setup.sh"
    exit 1
fi

echo "✅ Ambiente virtuale attivato"
echo "🔄 Eseguendo conversione..."

# Esegui il convertitore con tutti i parametri passati
python3 src/pdf_converter.py "$@"

# Deattiva l'ambiente
deactivate
echo "✅ Conversione completata"
