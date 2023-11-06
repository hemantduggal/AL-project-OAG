report 50022 encumbered
{
    Caption = 'Encumberance report';
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\encumbered.rdl';
    dataset
    {
        dataitem("Purchase Line"; "Purchase Line")
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
            column(No_; "No.")
            {

            }
            column(Document_No_; "Document No.")
            {

            }
            column(Order_Date; encumdate)
            {

            }
            column(Description; Description)
            {

            }
            column(Amount; Amount)
            {

            }
            trigger OnAfterGetRecord()
            var
                purhead: Record "Purchase Header";
            begin
                purhead.Reset();
                purhead.SetRange("Document Type", "Purchase Line"."Document Type");
                purhead.SetRange("No.", "Purchase Line"."Document No.");
                if purhead.FindFirst() then
                    encumdate := purhead.encumdate;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                field(edms; edms)
                {
                    Caption = 'Save Document';
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    var
                        FileName: Text[100];
                        EDMSLin1: DotNet EDMSL;
                        Resp: Text[2999];
                    begin
                        FileName := 'D:\Upload\' + 'Upload' + '.pdf';
                        REPORT.SaveAsPdf(REPORT::encumbered, FileName, "Purchase Line");
                        EDMSLin1 := EDMSLin1.EDMSUpload();
                        Resp := EDMSLin1.UploadFile('1040', '1049', FileName, 'BC200', 'encumbered');
                        Message(Resp);
                    end;
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
        edms: Label 'Click to Save';
        encumdate: DateTime;
}