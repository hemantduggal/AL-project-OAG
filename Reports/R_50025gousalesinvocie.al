report 50025 approvedinvoice
{
    Caption = 'Approved Invoices Report';
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\ApprovedInvoices.rdl';
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
            column(Companypicture; CompanyInfo.Picture)
            {

            }
            column(Posting_Date; "Posting Date")
            {

            }
            column(Due_Date; "Due Date")
            {

            }
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document No." = field("No.");
                column(Document_No_; "Document No.")
                {

                }
                column(Document_Type; "Document Type")
                {

                }
                column(Amount; Amount)
                {

                }
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