# PDF to PowerPoint Converter

Converte file PDF in presentazioni PowerPoint (.pptx) usando **PyMuPDF** per ottenere conversioni veloci e affidabili.

## 🚀 Caratteristiche

- ✅ **Veloce** - Ideale per PDF di qualsiasi dimensione
- ✅ **Semplice** - Solo 3 dipendenze Python
- ✅ **Configurabile** - Risoluzione e dimensioni personalizzabili
- ✅ **Affidabile** - Usa PyMuPDF (fitz) testato e stabile
- **Dipendenze**: `PyMuPDF`, `python-pptx`, `Pillow`

## ⚡ Installazione Rapida

### Setup Automatico (Raccomandato)

```bash
chmod +x setup.sh
./setup.sh
```

### Setup Manuale

```bash
pip install PyMuPDF python-pptx Pillow
```

## ⚙️ Configurazione

Modifica il file `config.json` per personalizzare il comportamento:

```json
{
    "file_paths": {
        "input_pdf": "test.pdf",
        "output_directory": "./output/"
    },
    "output_settings": {
        "default_output_name": "converted_presentation.pptx",
        "slide_dimensions": {
            "width_inches": 10,
            "height_inches": 7.5
        },
        "image_quality": {
            "matrix_scale": 2
        }
    }
}
```

### Opzioni Principali:
- **`matrix_scale`**: Scala per la risoluzione (1-3, maggiore = migliore qualità)
- **`slide_dimensions`**: Dimensioni delle slide in pollici
- **`input_pdf`**: File PDF da convertire
- **`default_output_name`**: Nome del file di output

## 🎯 Utilizzo

### Conversione Automatica
```bash
python3 src/pdf_converter.py
```

### Conversione Personalizzata
```bash
python3 src/pdf_converter.py input.pdf output.pptx
```

### Comandi Utili
```bash
# Mostra aiuto
python3 src/pdf_converter.py --help
```

## 📁 Struttura del Progetto

```
ConvertPDFToPPtx/
├── src/
│   ├── pdf-to-ppt-alternative.py   # Metodo originale (alternativo)
│   └── pdf_converter.py            # Convertitore principale
├── config.json                     # File di configurazione
├── setup.sh                        # Script setup automatico
├── requirements.txt                # Dipendenze Python
└── README.md                       # Documentazione
```

## 📋 Esempi di Output

Il convertitore produce file PPTX con:
- ✅ Una slide per ogni pagina del PDF
- ✅ Immagini centrate e ridimensionate
- ✅ Layout vuoto per massima flessibilità
- ✅ Proporzioni mantenute automaticamente

## 🔧 Troubleshooting

### Errori Comuni

**`ModuleNotFoundError: No module named 'fitz'`**
```bash
pip install PyMuPDF
# oppure
./setup.sh
```

**`ModuleNotFoundError: No module named 'pptx'`**
```bash
pip install python-pptx
# oppure
./setup.sh
```

**`File PDF non trovato`**
- Verifica il percorso nel `config.json`
- Assicurati che il file PDF esista

### Test Diagnostici
```bash
./setup.sh  # Include test completo delle dipendenze
```
