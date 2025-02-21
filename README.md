# MBen.EXCLUDE_FROM_CAPTURE
 Delphi Exclude your Window from Capture (Call SetWindowDisplayAffinity API)

https://github.com/user-attachments/assets/9b9c5c61-37a2-4a04-8ee2-3857334015ab
# Exclude Your Delphi Window from Capture

## Overview
This guide demonstrates how to exclude your Delphi VCL application window from being captured by screen recording or screenshot tools using the `SetWindowDisplayAffinity` API.

## Key Functionality
The Windows API `SetWindowDisplayAffinity` allows developers to set the display affinity of a window, providing an extra layer of security by preventing screen capture. This is particularly useful for applications handling sensitive information.

### Display Affinity Flags
- **WDA_NONE (`$0`)**: No display affinity.
- **WDA_MONITOR (`$1`)**: The window content is displayed only on a monitor.
- **WDA_EXCLUDEFROMCAPTURE (`$11`)**: The window is excluded from screen capture.

## Implementation in Delphi VCL

### Steps:
1. **Create a new VCL Forms Application.**
2. **Use `SetWindowDisplayAffinity`** in the `OnCreate` event to apply the exclusion.

### Example Code
```delphi
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, Vcl.Forms;

const
  WDA_EXCLUDEFROMCAPTURE = $11;

type
  TSecureForm = class(TForm)
  protected
    procedure FormCreate(Sender: TObject);
  end;

var
  SecureForm: TSecureForm;

implementation

{$R *.dfm}

procedure TSecureForm.FormCreate(Sender: TObject);
begin
  SetWindowDisplayAffinity(Handle, WDA_EXCLUDEFROMCAPTURE);
end;
```

## Benefits
- Protects sensitive data displayed in the window.
- Prevents unauthorized screen captures.
- Easy to implement within existing Delphi VCL projects.

## Notes
- `SetWindowDisplayAffinity` is only effective on Windows 7 and later.
- Some advanced screen recording tools may still bypass this protection.

## Demo
A video demonstration is available showing the implementation and effect of this technique.

---

Feel free to contribute or raise issues in this repository if you have questions or improvements!



