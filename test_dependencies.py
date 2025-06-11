#!/usr/bin/env python3

# Script di test per verificare le dipendenze installate
# PDF to PowerPoint Converter - Dependency Test

import sys
import subprocess

def test_module_import(module_name, import_statement, package_name=None):
    """Testa l'importazione di un modulo"""
    try:
        exec(import_statement)
        print(f"✓ {module_name}: OK")
        return True
    except ImportError as e:
        print(f"✗ {module_name}: ERRORE - {e}")
        if package_name:
            print(f"  Installa con: pip install {package_name}")
        return False

def check_python_path():
    """Mostra il percorso Python e i path dei moduli"""
    print(f"Python executable: {sys.executable}")
    print(f"Python version: {sys.version}")
    print("\nPython paths:")
    for path in sys.path:
        print(f"  {path}")

def check_pip_packages():
    """Controlla i pacchetti installati con pip"""
    try:
        result = subprocess.run([sys.executable, "-m", "pip", "list"], 
                              capture_output=True, text=True)
        lines = result.stdout.split('\n')
        
        packages_to_check = ['PyMuPDF', 'python-pptx', 'Pillow', 'pdf2image']
        found_packages = {}
        
        for line in lines:
            for package in packages_to_check:
                if line.lower().startswith(package.lower()):
                    found_packages[package] = line.strip()
        
        print("\nPacchetti installati:")
        for package in packages_to_check:
            if package in found_packages:
                print(f"✓ {found_packages[package]}")
            else:
                print(f"✗ {package}: Non trovato")
                
    except Exception as e:
        print(f"Errore nel controllo pacchetti: {e}")

def main():
    print("========================================")
    print("Test Dipendenze PDF to PPT Converter")
    print("========================================")
    
    # Informazioni Python
    check_python_path()
    print()
    
    # Test importazioni
    print("Test importazioni moduli:")
    modules_ok = 0
    total_modules = 4
    
    if test_module_import("PyMuPDF", "import fitz", "PyMuPDF"):
        modules_ok += 1
    
    if test_module_import("python-pptx", "from pptx import Presentation", "python-pptx"):
        modules_ok += 1
        
    if test_module_import("Pillow", "from PIL import Image", "Pillow"):
        modules_ok += 1
        
    if test_module_import("pdf2image", "from pdf2image import convert_from_path", "pdf2image"):
        modules_ok += 1
    
    print()
    check_pip_packages()
    
    print(f"\n========================================")
    print(f"Risultato: {modules_ok}/{total_modules} moduli funzionanti")
    
    if modules_ok == total_modules:
        print("✓ Tutte le dipendenze sono OK!")
        print("Puoi eseguire: python src/pdf_converter.py")
    else:
        print("✗ Alcune dipendenze mancano o non funzionano")
        print("\nSoluzioni:")
        print("1. Prova: python3 src/pdf_converter.py")
        print("2. Oppure: python -m pip install --user PyMuPDF python-pptx Pillow pdf2image")
        print("3. Oppure esegui: ./quick_install.sh")
    
    print("========================================")

if __name__ == "__main__":
    main()