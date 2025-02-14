## **If You Want `.tar.gz` (Standard for Folders)**  
Since `gzip` only compresses **single files**, we must first create a `.tar` archive before compressing.

#### **Zip a Folder to `.tar.gz`**
```sh
tar -czvf folder_name.tar.gz folder_name/
```
Example:
```sh
tar -czvf CS02_7.tar.gz CS02_7/
```

#### **Unzip `.tar.gz`**
```sh
tar -xzvf CS02_7.tar.gz
```

---

### **If You Want `.gz` (But It's Actually a `.tar.gz`)**  
If the requirement is to have a **`.gz` file** even though it’s a folder, you **must first tar it** and then rename it.

#### **Zip a Folder to `.gz`**
```sh
tar -cf - CS02_7/ | gzip > CS02_7.gz
```
or in two steps:
```sh
tar -cf CS02_7.tar CS02_7/
gzip CS02_7.tar
mv CS02_7.tar.gz CS02_7.gz
```

#### **Unzip `.gz` (That Was a Folder)**
```sh
gunzip -c CS02_7.gz | tar -xf -
```

---

### **Key Takeaways**
- `.tar.gz` = Tar archive compressed with `gzip`  
- `.gz` alone is typically for single files, but renaming a `.tar.gz` to `.gz` works the same  
- Use `tar -czvf` to compress a folder and `tar -xzvf` to extract it  
