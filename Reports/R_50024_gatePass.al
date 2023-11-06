report 50024 gatepass
{
    Caption = 'Gate Pass Report';
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\Gatepass.rdl';
    dataset
    {
        dataitem("Fixed Asset"; "Fixed Asset")
        {
            RequestFilterFields = "No.";
            column(CompanyName; CompanyInfo.Name)
            {

            }
            column(Companyadd; CompanyInfo.Address)
            {

            }
            column(Companyadd2; CompanyInfo."Address 2")
            {

            }
            column(Companycity; CompanyInfo.City)
            {

            }
            column(Companypicture; CompanyInfo.Picture)
            {

            }
            column(No_; "No.")
            {

            }
            column(Serial_No_; "Serial No.")
            {

            }
            column(Description; Description)
            {

            }
            column(qty; qty)
            {

            }
        }
    }
    trigger OnPreReport()
    begin
        companyinfo.get();
        companyinfo.CalcFields(Picture);
        qty := 1;
    end;

    var
        qty: Integer;
        companyinfo: Record "Company Information";
}