#!/bin/bash

# Installa le dipendenze necessarie
echo "Installazione delle dipendenze..."
pip install PyMuPDF python-pptx Pillow

# Verifica che il file PDF esista
if [ ! -f "test.pdf" ]; then
    echo "Errore: Il file test.pdf non è stato trovato nella directory corrente."
    echo "Assicurati che il file PDF sia presente prima di eseguire lo script."
    exit 1
fi

# Esegui lo script Python alternativo
echo "Esecuzione dello script pdf-to-ppt-alternative.py..."
python pdf-to-ppt-alternative.py

# Verifica se l'esecuzione è andata a buon fine
if [ $? -eq 0 ]; then
    echo "Conversione completata con successo!"
    echo "Il file pdf-to-ppt-free.pptx è stato creato."
else
    echo "Errore durante l'esecuzione dello script."
    exit 1
fi