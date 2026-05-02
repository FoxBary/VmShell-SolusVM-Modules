# VmShell-SolusVM-Modules

**作者:** VmShell INC  
**官網:** [https://vmshell.com/](https://vmshell.com/)

---

## 項目簡介

**VmShell-SolusVM-Modules** 是由 **VmShell INC** 官方維護的 WHMCS 服務器插件。本插件基於 SolusVM Pro 進行深度優化與功能增強，旨在為用戶提供更流暢、更直觀的 VPS 管理體驗，同時為管理員提供高度自動化的運維支持。

本插件特別針對 NAT 環境及 KVM/OpenVZ 架構進行了適配，是構建現代化雲計算服務平台的理想選擇。

---

## 核心功能

### 1. 全面的架構支持
*   **KVM & OpenVZ:** 完美支持主流虛擬化技術（Xen 架構未經完整測試，請酌情使用）。
*   **NAT 適配:** 內置 NAT 網絡優化，支持自動顯示 NAT 端口轉發規則（需配合特定 NAT 腳本）。

### 2. 強大的用戶控制面板
用戶無需離開 WHMCS 即可完成絕大部分日常操作：
*   **系統管理:** 一鍵重裝操作系統、修改 Root 登錄密碼。
*   **網絡功能:** KVM 網絡重置、實時顯示分配的 IP 地址及 NAT 端口。
*   **遠程訪問:** 集成 HTML5 VNC 控制台、Java VNC 及 SSH 串行控制台，確保在任何網絡環境下都能訪問服務器。
*   **實時監控:** 動態顯示 CPU 使用率、RAM 佔用及流量消耗情況，圖表化呈現服務器狀態。
*   **高級開關:** 支持 OpenVZ TUN/TAP 模式切換。

### 3. 管理員自動化運維
*   **WHMCS 深度集成:** 支持 WHMCS 8.x 版本，實現從下單到開通的全自動化流程。
*   **一鍵管控:** 管理後台支持一鍵暫停、解除暫停、終止服務及重啟等操作。
*   **靈活配置:** 支持手動設置產品是否為 NAT 模式、初始流量配額等自定義參數。

---

## 部署與安裝

### 方式一：手動安裝（推薦）
1. 下載最新的 Release 壓縮包。
2. 將解壓後的檔案上傳至 WHMCS 安裝根目錄。
3. 確保路徑為 `/modules/servers/solusvmplus/`。

### 方式二：Git 部署
進入 WHMCS 的 `modules/servers` 目錄，執行以下命令：
```bash
git clone https://github.com/vmshell/VmShell-SolusVM-Modules.git solusvmplus
```

---

## 使用說明與建議

*   **API 通訊:** 若遇到 API 通訊失敗，請檢查防火牆設置，並嘗試將通訊端口更改為 `5656`。
*   **NAT 腳本:** 為了實現 NAT 端口的自動顯示，請確保您的服務端已部署相應的數據接口。

---

## 許可與聲明

*   **開源協議:** 本項目遵循開源精神，任何人均可免費使用。
*   **嚴禁倒賣:** **VmShell INC** 嚴禁任何個人或組織對本插件進行二次倒賣。
*   **技術支持:** 歡迎在 GitHub 提交 Issue 或通過官網聯繫我們。

---
© 2026 VmShell INC. All Rights Reserved.
