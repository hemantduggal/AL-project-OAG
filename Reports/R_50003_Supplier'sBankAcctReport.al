report 50003 Supplier_BankAcc_Report
{
    UsageCategory = Administration;
    ApplicationArea = All;
    Caption = 'Supplier Bank Account Report';
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\Supplier_BankAcc_Report.rdl';

    dataset
    {
        dataitem("Vendor Bank Account"; "Vendor Bank Account")
        {
            RequestFilterFields = "Vendor No.";
            column(CompanyName; CompanyInfo.Name)
            {

            }
            column(Vendor_No_; "Vendor No.")
            {

            }
            column(VendorName; RecVendor.Name)
            {

            }
            column(BankName; Name)
            {

            }
            column(BranchName; "Address 2")
            {

            }
            column(Bank_Branch_No_; "Bank Branch No.")
            {

            }

            column(Bank_Account_No_; "Bank Account No.")
            {

            }
            column(Created_Date; "Created Date")
            {

            }
            column(Created_By; "Created By")
            {

            }
            column(Last_Modified_Date; "Last Modified Date")
            {

            }
            column(Last_Modified_By; "Last Modified By")
            {

            }
            trigger OnAfterGetRecord()
            begin
                if RecVendor.Get("Vendor Bank Account"."Vendor No.") then;
                //if bank.get(Code) then;
            end;
        }
    }
    trigger OnPreReport()
    var

    begin
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(CompanyInfo.Picture);

    end;

    var
        CompanyInfo: Record "Company Information";
        RecVendor: Record Vendor;
    // bank: Record "Bank Account";
}