report 50016 "Budget Performance Recur-Dev"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    Caption = 'Budget Performance Recur-Dev Report';
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\BudgetPerformanceRecur-Dev_Report.rdl';


    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            column(CompanyName; CompanyInfo.Name)
            {

            }
            column(Companypicture; CompanyInfo.Picture)
            {

            }
            column(No_; "No.")
            {

            }
            column(Vendor_Invoice_No_; "Vendor Invoice No.")
            {

            }
            column(FromDate; FromDate)
            {

            }
            column(ToDate; ToDate)
            {

            }

            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document No." = field("No.");

                column(Document_No_; "Document No.")
                {

                }

            }
            //>>>>>Header Trigger
            trigger OnPreDataItem()
            var
            begin
                //    SetRange("Posting Date", FromDate, ToDate);
            end;

            trigger OnAfterGetRecord()
            begin
            end;
        }
    }
    /* requestpage
     {
         SaveValues = true;

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
                         Visible = false;
                         trigger OnValidate()
                         begin

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
     }*/
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
        FromDate: Date;
        ToDate: Date;
}