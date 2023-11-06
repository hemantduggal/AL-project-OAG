report 50001 "Form5 PDU Report"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    Caption = 'Form5 Report';
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\Form 5-CReport.rdl';//Form5PDU_Report.rdl';


    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            RequestFilterFields = "No.";
            column(No_; "No.")
            {

            }
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
            column(Reference_No_; "Reference No.")
            {

            }
            column(Subject_of_Procurement; "Subject of Procurement")
            {

            }
            column(Location_Code; "Location Code")
            {

            }
            column(Currency_Code; "Currency Code")
            {

            }
            dataitem("Purchase Line"; "Purchase Line")

            {
                DataItemLink = "Document No." = field("No.");

                column(Document_No_; "Document No.")
                {

                }
                column(ItemNo; "No.")
                {

                }
                column(Line_Description; Description)
                {

                }
                column(Quantity; Quantity)
                {

                }
                column(Unit_of_Measure; "Unit of Measure")
                {

                }
                column(Unit_Cost; "Unit Cost")
                {

                }
                column(Amount; Amount)
                {

                }
                trigger OnPreDataItem()
                var

                begin
                end;

                trigger OnAfterGetRecord()
                var

                begin
                    //  SNo := SNo + 1;


                end;
            }

            trigger OnPreDataItem()
            var

            begin

            end;

            trigger OnAfterGetRecord()
            var
            begin

            end;
        }
    }

    trigger OnPreReport()
    var

    begin
        //SNo := 0;
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(CompanyInfo.Picture);


    end;

    trigger OnPostReport()
    var

    begin

    end;

    var
        CompanyInfo: Record "Company Information";
        SNo: Integer;

}


