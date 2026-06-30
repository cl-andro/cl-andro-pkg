# AI Guide: Building Web Extensions for Cluster Browser & cl-andro

This document serves as a specialized reference and rule set for AI coding agents operating within the `cl-andro` (PRoot-distro) terminal environment. It defines the architecture, directory schemas, and execution patterns required to successfully build and deploy extensions for the Chromium-based **Cluster Browser**.

---

## 1. Directory Structure

All browser extensions must reside natively within the terminal user's home directory under `~/extensions/` (which translates to `/data/data/com.zk.clandro/files/home/extensions/` in Android path format).

```text
$HOME/extensions/
└── <extension-name>/
    ├── manifest.json            # Extension Metadata and Rules
    ├── content.js               # Frontend JavaScript Injected into Browser Tabs
    └── server.py                # Optional Local Backend Service (e.g. Python HTTP/WebSocket)
```

---

## 2. Manifest Schema (`manifest.json`)

The manifest configuration defines versioning, frontend scripts injection rules, and local backend server details.

```json
{
  "manifest_version": 3,
  "name": "Local Markdown Parser",
  "version": "1.0.0",
  "description": "Scans page for Markdown text and renders it locally using the python backend server.",
  "content_scripts": [
    {
      "matches": ["*://*/*"],
      "js": ["content.js"]
    }
  ],
  "backend": {
    "runtime": "python3",
    "script": "server.py",
    "default_port": 18081
  }
}
```

### Manifest Fields Definition
* **`manifest_version`**: Must strictly be `3`.
* **`name`**: Descriptive title of the extension (shown in settings screen).
* **`version`**: Semantic versioning string (e.g., `1.0.0`).
* **`description`**: Brief summary describing the extension's purpose.
* **`content_scripts`**: Specifies match patterns and target JS files:
  * **`matches`**: Array of URL match pattern globs. Supported formats:
    * `*://*/*` (matches all HTTP/HTTPS pages)
    * `https://*.example.com/*` (matches subdomains)
    * `<all_urls>` (matches all valid web URLs)
  * **`js`**: List of relative paths to the JS scripts to inject.
* **`backend` (Optional)**: Specifies local backend daemon options:
  * **`runtime`**: Environment executable (e.g. `python3`, `node`).
  * **`script`**: Name of the entrypoint file to run.
  * **`default_port`**: Local host port to allocate for backend routing.

---

## 3. Frontend Script Specifications (`content.js`)

Frontend scripts are injected into matching web pages when page loading completes (`onPageLoadFinished`). 

### Execution Context
> [!IMPORTANT]
> The scripts are evaluated inside the web page context via Chromium's `WebContents.evaluateJavaScript` engine. Standard Chrome Extension APIs (like `chrome.runtime`, `chrome.storage`, or `chrome.tabs`) **are NOT available**. 

### Backend Communication
To communicate with the extension's local python backend, frontend scripts should use standard Web API `fetch()` queries pointing to `http://localhost:<default_port>`:

```javascript
// Example: Sending data from tab to server.py backend
fetch("http://localhost:18081/parse", {
    method: "POST",
    headers: {
        "Content-Type": "application/json"
    },
    body: JSON.stringify({ html: document.body.innerHTML })
})
.then(response => response.json())
.then(data => {
    console.log("Response from local backend:", data);
})
.catch(err => console.error("Failed to query extension backend:", err));
```

---

## 4. Backend Service Specifications (`server.py`)

If an extension requires local processing (such as executing local AI model inference, filesystem writes, or script execution), it should run a local Python HTTP/WebSocket server.

### CORS Requirement
> [!CAUTION]
> Because frontend scripts run inside web pages, backend servers **MUST** explicitly support and permit Cross-Origin Resource Sharing (CORS) headers. Otherwise, browser security engines will block queries.

```python
# Example: Lightweight Python CORS-compliant HTTP Server
import http.server
import socketserver
import json

PORT = 18081

class ExtensionHandler(http.server.SimpleHTTPRequestHandler):
    def end_headers(self):
        # Enable CORS headers for browser queries
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Access-Control-Allow-Methods', 'GET, POST, OPTIONS')
        self.send_header('Access-Control-Allow-Headers', 'Content-Type')
        super().end_headers()

    def do_OPTIONS(self):
        self.send_response(200)
        self.end_headers()

    def do_POST(self):
        content_length = int(self.headers['Content-Length'])
        post_data = self.rfile.read(content_length)
        
        # Process incoming payload
        # ...
        
        self.send_response(200)
        self.send_header('Content-type', 'application/json')
        self.end_headers()
        
        response = {"status": "success", "data": "processed"}
        self.wfile.write(json.dumps(response).encode('utf-8'))

if __name__ == "__main__":
    with socketserver.TCPServer(("", PORT), ExtensionHandler) as httpd:
        print(f"Extension backend active on port {PORT}")
        httpd.serve_forever()
```

---

## 5. Deployment and Dynamic Reloading

When an AI agent creates or modifies an extension, it must notify the **Cluster Browser** to immediately refresh its internal extensions registry without requiring a browser app restart.

### Refresh IPC Command
After saving manifest changes or adding extensions, execute the following broadcast intent from the `cl-andro` shell:

```bash
am broadcast -a com.zk.clusterBrowser.REFRESH_EXTENSIONS
```

### Verification Pipeline
When building or updating extensions, follow this sequence:
1. Write files directly to `~/extensions/<your-extension>/`.
2. Send the broadcast intent to trigger the browser's dynamic reload.
3. Open or switch to Cluster Browser and verify the status under **Settings -> Web Extensions** or via the header **Terminal Menu -> Web Extensions**.
