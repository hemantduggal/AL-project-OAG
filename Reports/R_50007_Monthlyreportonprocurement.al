report 50007 "Monthly report on procurement"
{
    ApplicationArea = All;
    Caption = 'Monthly report on procurement';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\monthlyprocrument.rdl';
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
            column(Requisition_Slip_No_; "Requisition Slip No.")
            {

            }
            column(Subject_of_Procurement; "Subject of Procurement")
            {

            }
            column(Buy_from_Vendor_No_; "Buy-from Vendor No.")
            {

            }
            column(Buy_from_Vendor_Name; "Buy-from Vendor Name")
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

            }
        }

    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
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
