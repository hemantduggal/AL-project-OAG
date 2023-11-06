report 50028 "MSME_Report - ITI"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    Caption = 'MSME Report';
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\MSME.rdl';


    dataset
    {
        dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
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
            column(Vendor_No_; "Vendor No.")
            {

            }
            column(Vendor_Name; vend.Name)
            {

            }
            column(Document_No_; "Document No.")
            {

            }
            column(Document_Date; "Posting Date")
            {

            }
            column(Amount__LCY_; "Amount (LCY)")
            {

            }
            column(outstandingamt; outstandingamt)
            {

            }
            column(addition; addition)
            {

            }
            column(paid; paid)
            {

            }
            column(balance; balance)
            {

            }
            column(sno; sno)
            {

            }

            trigger OnAfterGetRecord()
            begin
                sno += 1;
                Clear(outstandingamt);
                Clear(addition);
                Clear(paid);
                Clear(balance);
                vendorledger.Reset();
                vendorledger.SetRange("Vendor No.", "Vendor Ledger Entry"."Vendor No.");
                vendorledger.SetRange("Posting Date", 0D, fromdate);
                if vendorledger.FindSet() then
                    repeat
                        vendorledger.CalcFields("Amount (LCY)", Amount);
                        outstandingamt += vendorledger."Amount (LCY)";
                    until vendorledger.Next() = 0;
                vendorledger.Reset();
                vendorledger.SetRange("Vendor No.", "Vendor Ledger Entry"."Vendor No.");
                vendorledger.SetRange("Posting Date", fromdate, todate);
                if vendorledger.FindSet() then
                    repeat
                        vendorledger.CalcFields("Amount (LCY)", Amount);
                        addition += vendorledger."Amount (LCY)";
                    until vendorledger.Next() = 0;
                vendorledger.Reset();
                vendorledger.SetRange("Vendor No.", "Vendor Ledger Entry"."Vendor No.");
                vendorledger.SetRange("Document Type", vendorledger."Document Type"::Payment);
                vendorledger.SetRange("Posting Date", fromdate, todate);
                if vendorledger.FindSet() then
                    repeat
                        vendorledger.CalcFields("Amount (LCY)", Amount);
                        paid += vendorledger."Amount (LCY)";
                    until vendorledger.Next() = 0;
                vendorledger.Reset();
                vendorledger.SetRange("Vendor No.", "Vendor Ledger Entry"."Vendor No.");
                vendorledger.SetRange("Posting Date", 0D, todate);
                if vendorledger.FindSet() then
                    repeat
                        vendorledger.CalcFields("Amount (LCY)", Amount);
                        balance += vendorledger."Amount (LCY)";
                    until vendorledger.Next() = 0;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group("Date Filter")
                {
                    Caption = 'Date Filter';
                    field(FromDate; FromDate)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'From Date';
                        //  Visible = false;
                        trigger OnValidate()
                        begin
                            //if ToDate = 0D then
                            //  Error('Enter Date');
                        end;
                    }
                    field(ToDate; ToDate)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'To Date';
                        trigger OnValidate()
                        begin

                        end;
                    }
                }
            }
        }
    }
    trigger OnPreReport()
    var

    begin
        sno := 0;
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(CompanyInfo.Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        sno: Integer;
        vend: Record Vendor;
        fromdate: date;
        todate: date;
        outstandingamt: Decimal;
        addition: Decimal;
        paid: Decimal;
        balance: Decimal;
        vendorledger: Record "Vendor Ledger Entry";
}