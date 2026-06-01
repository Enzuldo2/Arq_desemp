import pypdf

reader = pypdf.PdfReader("Prática.pdf")
print("Number of pages:", len(reader.pages))

for i, page in enumerate(reader.pages):
    print(f"\n--- Page {i+1} ---")
    print("Images found:", len(page.images))
    for j, img in enumerate(page.images):
        name = img.name
        print(f"  Image {j+1}: {name}")
        with open(f"extracted_page_{i+1}_img_{j+1}_{name}", "wb") as fp:
            fp.write(img.data)
