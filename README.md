#  复制文件树到剪贴板 (Copy Folder Tree to Clipboard)

一个轻量级、原生无依赖的 Windows 右键菜单增强工具。只需右键点击任意文件夹，即可一键将该文件夹及其所有子目录、文件生成漂亮的树形结构（Tree），并自动复制到系统剪贴板中。

非常适合用于编写项目文档、记录目录结构或向他人展示文件层级。

##  效果展示

```text
C:\Windows\System32
┣━📁 0409 
┃  ┣━📁 AdvancedInstallers
┃  ┗━▷📄 cmiv2.dll
┣━📁 am-et
┣━📁 AMD
┃  ┣━📁 amdfendr
┃  ┃  ┣━▷📄 amdfendr.cat
┃  ┃  ┣━▷📄 amdfendr.inf
┃  ┃  ┗━▷📄 amdfendr.sys
┃  ┗━📁 amdkmdap 
┃     ┗━▷📄 amdkmdap.ctz
┗━📁 AppReadiness
   ┗━▷📄 AppReadiness.exe
```
**生成的目录树：**

![目录树生成效果](CopyFolderTree/images/tree-example.png)

**右键菜单集成：**

![右键菜单截图](CopyFolderTree/images/context-menu.png)
##  功能特点

- **原生无依赖**：纯 PowerShell + Batch 实现，无需安装 Python、Node.js 等第三方运行环境。
- **树形结构清晰**：采用 `┣━`、`┗━`、`┃` 等标准制表符，排版完美对齐。
- **直观的图标标识**：自动为文件夹（📁）和文件（📄▷）添加 Emoji 和符号标识。
- **全面兼容**：使用 `-Force` 参数，支持遍历并显示隐藏文件、系统文件。
- **安全隔离**：核心脚本自动复制到 `%LOCALAPPDATA%` 目录下运行，不污染原文件夹。
- **一键卸载**：提供卸载脚本，自动清理注册表与本地缓存文件，无残留。

##  文件说明

- `复制文件夹结构到剪贴板.ps1`：核心 PowerShell 脚本，负责递归读取目录并生成文本写入剪贴板。
- `install.bat`：一键安装脚本（写入注册表右键菜单，复制 PS1 文件至系统目录）。
- `uninstall.bat`：一键卸载脚本（清除右键菜单及缓存文件）。

##  安装指南

1. 下载本项目所有文件，并解压到同一个文件夹中。
2. **右键点击 `install.bat`，选择「以管理员身份运行」**。
   *(注：写入注册表 `HKEY_CLASSES_ROOT` 需要管理员权限)*。
3. 看到「安装成功」提示后即可使用。

##  使用方法

安装成功后，在 Windows 资源管理器中：
1. 找到你想要导出的文件夹。
2. **右键**点击该文件夹。
3. 在菜单中选择 **「复制文件夹结构到剪贴板」**。
4. 稍等片刻（视文件夹大小而定），即可将剪贴板内容粘贴（`Ctrl+V`）到记事本、Word 或 Markdown 编辑器中。

##  自定义配置

如果你想要修改缩进宽度或更改图标，可以编辑 `复制文件夹结构到剪贴板.ps1` 文件开头的「配置区」：

```powershell
# ========== 配置区 ==========
# 缩进宽度：每个层级增加的空格数（建议 4，若需更宽请修改此值）
$indentWidth = 4
# 自定义文件夹名称前后缀
$folderPrefix = '📁'
$folderSuffix = ' '
# 自定义文件名称前后缀（保留前面的 ▷ 符号）
$filePrefix = '📄'
$fileSuffix = ' '
# ===========================
```
*修改后，需要重新运行 `install.bat` 覆盖安装，或直接替换 `%LOCALAPPDATA%\CopyFolderTree\CopyFolderTree.ps1` 中的文件即可生效。*

##  卸载指南

1. **右键点击 `uninstall.bat`，选择「以管理员身份运行」**。
2. 脚本会自动删除注册表中的右键菜单项，并清理 `%LOCALAPPDATA%\CopyFolderTree` 缓存目录。

##  注意事项

- **编码问题**：如果你的系统语言为中文，请确保 `.bat` 文件以 **ANSI** 或 **GBK** 编码保存，否则控制台可能会出现中文乱码。
- **杀毒软件提示**：由于工具涉及修改注册表（`reg add`）和调用 PowerShell，部分安全软件可能会弹窗拦截，请选择「允许执行」。
- **超大文件夹**：如果右键点击的是整个 `C:\` 盘或极其巨大的目录，生成过程可能会需要几秒钟，期间请耐心等待，不要连续多次点击。

## 开源协议

 [MIT License](https://opensource.org/licenses/MIT) 
