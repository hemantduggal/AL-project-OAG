report 50021 appropriationByNature
{
    Caption = 'Appropriation by Nature';
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\appropriationByNature.rdl';
    dataset
    {
        dataitem("G/L Budget Entry"; "G/L Budget Entry")
        {
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
        }
    }
    trigger OnPreReport()
    begin
        companyinfo.get();
        companyinfo.CalcFields(Picture);
    end;

    var
        companyinfo: Record "Company Information";
}