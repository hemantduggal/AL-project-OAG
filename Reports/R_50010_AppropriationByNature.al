report 50010 "Appropriation by Nature"
{
    UsageCategory = Administration;
    // ApplicationArea = All;
    Caption = 'Appropriation by Nature Report';
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\AppropriationbyNature_Report.rdl';

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
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

            column(Companystate; CompanyState)
            {

            }

            column(Companycountry; CompanyCountry)
            {

            }
            column(Companypicture; CompanyInfo.Picture)
            {

            }
        }
    }
    trigger OnPreReport()
    var

    begin
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(CompanyInfo.Picture);


    end;

    trigger OnPostReport()
    var

    begin

    end;

    var
        CompanyInfo: Record "Company Information";
        RecCountryregion: Record "Country/Region";
        CompanyState: Text;
        CompanyCountry: Text;
}