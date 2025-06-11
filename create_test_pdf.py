#!/usr/bin/env python3

# Script per creare un PDF di test
# Utile per testare il convertitore senza avere PDF esistenti

try:
    from reportlab.pdfgen import canvas
    from reportlab.lib.pagesizes import letter
except ImportError:
    print("reportlab non installato. Installa con: pip install reportlab")
    exit(1)

def create_test_pdf(filename="test.pdf"):
    """Crea un PDF di test con alcune pagine"""
    c = canvas.Canvas(filename, pagesize=letter)
    width, height = letter
    
    # Pagina 1
    c.setFont("Helvetica-Bold", 24)
    c.drawString(100, height - 100, "PDF di Test - Pagina 1")
    c.setFont("Helvetica", 12)
    c.drawString(100, height - 150, "Questo è un PDF di test creato automaticamente")
    c.drawString(100, height - 170, "per testare il convertitore PDF to PowerPoint.")
    
    # Disegna un rettangolo
    c.setStrokeColorRGB(0, 0, 1)  # Blu
    c.setFillColorRGB(0.8, 0.8, 1)  # Azzurro chiaro
    c.rect(100, height - 300, 200, 100, fill=1)
    
    c.showPage()
    
    # Pagina 2
    c.setFont("Helvetica-Bold", 24)
    c.drawString(100, height - 100, "PDF di Test - Pagina 2")
    c.setFont("Helvetica", 12)
    c.drawString(100, height - 150, "Seconda pagina del documento di test")
    
    # Disegna un cerchio
    c.setStrokeColorRGB(1, 0, 0)  # Rosso
    c.setFillColorRGB(1, 0.8, 0.8)  # Rosa chiaro
    c.circle(200, height - 250, 50, fill=1)
    
    c.showPage()
    
    # Pagina 3
    c.setFont("Helvetica-Bold", 24)
    c.drawString(100, height - 100, "PDF di Test - Pagina 3")
    c.setFont("Helvetica", 12)
    c.drawString(100, height - 150, "Terza ed ultima pagina")
    c.drawString(100, height - 170, "Pronto per la conversione in PowerPoint!")
    
    # Disegna delle linee
    c.setStrokeColorRGB(0, 1, 0)  # Verde
    c.line(100, height - 250, 300, height - 250)
    c.line(100, height - 270, 300, height - 270)
    c.line(100, height - 290, 300, height - 290)
    
    c.save()
    print(f"✓ PDF di test creato: {filename}")

if __name__ == "__main__":
    create_test_pdf()
    print("Ora puoi testare il convertitore con:")
    print("  python3 src/pdf_converter.py")