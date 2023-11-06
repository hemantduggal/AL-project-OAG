report 50023 catering
{
    Caption = 'Catering Report';
    UsageCategory = Administration;
    // ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\catering.rdl';
    dataset
    {
        dataitem("Catering Header"; "Catering Header")
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
            column(Description; Description)
            {

            }
            column(meetingdate; meetingdate)
            {

            }
            column(meetingTime; meetingTime)
            {

            }
            column(Venue; Venue)
            {

            }
            column(expectedParticipent; expectedParticipent)
            {

            }
            column("UserID1"; "1st Approved/Rejected User ID")
            {

            }
            column("User_ID2"; "2nd Approved/Rejected User ID")
            {

            }
            column(user; user)
            {

            }
            dataitem("Catering Lines"; "Catering Lines")
            {
                DataItemLink = docno = field("No.");
                column(NoOfDays; NoOfDays)
                {

                }
                column(CateringItem; CateringItem)
                {

                }
                column(Descriptionline; Description)
                {

                }
                column(quantity; quantity)
                {

                }
                column(UnitCost; UnitCost)
                {

                }
                column(servingTime; servingTime)
                {

                }
                column(Amount; Amount)
                {

                }
            }
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
                        REPORT.SaveAsPdf(REPORT::catering, FileName, "Catering Header");
                        EDMSLin1 := EDMSLin1.EDMSUpload();
                        Resp := EDMSLin1.UploadFile('1040', '1050', FileName, 'BC200', 'Catering');
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
}