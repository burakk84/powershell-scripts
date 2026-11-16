## Script Details: `sifre_lock_expire.ps1`

This interactive script allows IT Helpdesk and System Administrators to query Active Directory users, check their password expiration and account lockout status, and unlock locked accounts in a continuous loop.

### Prerequisites
* **Active Directory PowerShell Module** (`RSAT-AD-PowerShell`) installed on the machine.
* Appropriate permissions to read user properties and unlock accounts in Active Directory.

### Usage
1. Open **PowerShell** as Administrator.
2. Navigate to the directory where you saved the script:
   ```powershell
   cd C:\(\path\to\script \%\%\)MAGIT_PARSER_PROTECT%%   ```
3. Run the script:
   ```powershell
   .\sifre_lock_expire.ps1
   ```
4. Follow the on-screen prompts to check user status or unlock accounts.
