report 50008 "Purchase Order Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Purchase Order Report';
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\Purchase Order Report.rdl';

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            RequestFilterFields = "No.";
            column(cmpname; CompanyInfo.name)
            {

            }
            column(cmpadd; CompanyInfo.Address)
            {

            }
            column(cmpadd2; CompanyInfo."Address 2")
            {

            }
            column(cmpcity; CompanyInfo.City)
            {

            }
            column(cmpcountry; CompanyInfo."Country/Region Code")
            {

            }
            column(cmppic; CompanyInfo.Picture)
            {

            }
            column(Location_Code; "Location Code")
            {

            }
            column(Posting_Date; "Posting Date")
            {

            }
            column(Currency_Code; "Currency Code")
            {

            }
            column(Buy_from_Vendor_Name; "Buy-from Vendor Name")
            {

            }
            column(PONo; "No.")
            {

            }
            column(Ship_to_Name; "Ship-to Name")
            {

            }
            column(Ship_to_Address; "Ship-to Address")
            {

            }
            column(Ship_to_Address_2; "Ship-to Address 2")
            {

            }
            column(Ship_to_City; "Ship-to City")
            {

            }
            column(Ship_to_County; "Ship-to County")
            {

            }

            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.");

                column(sno; sno)
                {

                }

                column(No_; "No.")
                {

                }
                column(Description; Description)
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
                trigger OnAfterGetRecord()
                begin
                    sno := sno + 1
                end;

            }

        }
    }


    trigger OnPreReport()
    begin
        CompanyInfo.get;
        CompanyInfo.CalcFields(CompanyInfo.Picture);
        sno := 0;


    end;

    var

        sno: Integer;
        CompanyInfo: Record "Company Information";
}