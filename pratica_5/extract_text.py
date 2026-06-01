import pypdf

def extract_pdf_text(pdf_path, txt_path):
    reader = pypdf.PdfReader(pdf_path)
    text = ""
    for i, page in enumerate(reader.pages):
        text += f"--- PAGE {i+1} ---\n"
        page_text = page.extract_text()
        if page_text:
            text += page_text + "\n"
        else:
            text += "[No text found on this page]\n"
    
    with open(txt_path, "w", encoding="utf-8") as f:
        f.write(text)
    print(f"Extracted {len(reader.pages)} pages. Saved to {txt_path}")

if __name__ == "__main__":
    extract_pdf_text("Prática.pdf", "pratica_text.txt")
