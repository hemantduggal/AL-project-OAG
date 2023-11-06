report 50019 budgetperformance
{
    Caption = 'Budget Performance Report';
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\BudgetPerformanceReportLG.rdl';
    dataset
    {
        dataitem("G/L Budget Entry"; "G/L Budget Entry")
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
            column(G_L_Account_No_; "G/L Account No.")
            {

            }
            column(Amount; Amount)
            {

            }
            column(Budget_Code; "Budget Code")
            {

            }
            column(Budget_Dimension_1_Code; "Budget Dimension 1 Code")
            {

            }
            column(Budget_Dimension_2_Code; "Budget Dimension 2 Code")
            {

            }
            column(Budget_Dimension_3_Code; "Budget Dimension 3 Code")
            {

            }
            column(Budget_Dimension_4_Code; "Budget Dimension 4 Code")
            {

            }
        }
    }
    trigger OnPreReport()
    begin
        CompanyInfo.get;
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
}
