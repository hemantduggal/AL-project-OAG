report 50000 "Store Requisition Order Report"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    Caption = 'Store Requisition Order Report';
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\storesReqOrder.rdl';//'ReportLayout\StoreRequisition_Report.rdl';


    dataset
    {
        dataitem("Requisition Header"; "Requisition Header")
        {
            RequestFilterFields = "Requisition Slip No.";
            column(Requisition_Slip_No_; "Requisition Slip No.")
            {

            }
            column(Description; Description)
            {

            }
            column(Request_Date; "Request Date")
            {

            }
            column(Request_Department; Department)
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

            column(Companystate; CompanyState)
            {

            }

            column(Companycountry; CompanyCountry)
            {

            }
            column(Companypicture; CompanyInfo.Picture)
            {

            }
            column(Requested_User_ID; "Requested User ID")
            {

            }
            column("First_ApprovedUser"; "1st Approved/Rejected User ID")
            {

            }
            column("First_ApprovedDate"; "1st Approved/Rejected Date")
            {

            }
            column("Second_ApprovedUser"; "2nd Approved/Rejected User ID")
            {

            }
            column("Second_ApprovedDate"; "2nd Approved/Rejected Date")
            {

            }
            dataitem(Requisition_Line; Requisition_Line)

            {
                DataItemLink = "Requisition Slip No." = field("Requisition Slip No.");

                column(SNo; SNo)
                {

                }
                column(No_; "No.")
                {

                }
                column(Line_Description; Description)
                {

                }
                column(Request_Quantity; "Request Quantity")
                {

                }
                column(Issued_Quantity; "Issued Quantity")
                {

                }
                column(Unit_Of_Measure_Code; "Unit Of Measure Code")
                {

                }
                column(Unit_Cost; "Unit Cost")
                {

                }
                column(Amount; Amount)
                {

                }
                column(Comment; Comment)
                {

                }

                trigger OnPreDataItem()
                var

                begin
                end;

                trigger OnAfterGetRecord()
                var

                begin
                    SNo := SNo + 1;


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
        SNo := 0;
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
        SNo: Integer;

}


