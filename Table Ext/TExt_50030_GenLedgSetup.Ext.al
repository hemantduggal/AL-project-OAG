tableextension 50030 GenleddSetupExt extends "General Ledger Setup"
{
    fields
    {

        field(50000; "Manual Sales WHT Calc."; Boolean)
        {
            Caption = 'Manual Sales WHT Calc.';
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG WHT_0.1';
        }
        field(50001; "Enable WHT"; Boolean)
        {
            Caption = 'Enable WHT';
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG WHT_0.1';
        }
        field(50002; "Enable Tax Invoices"; Boolean)
        {
            Caption = 'Enable Tax Invoices';
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG WHT_0.1';
        }
        field(50003; "Print Tax Invoices on Posting"; Boolean)
        {
            Caption = 'Print Tax Invoices on Posting';
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG WHT_0.1';
        }
        field(50004; "Round Amount for WHT Calc"; Boolean)//this
        {
            Caption = 'Round Amount for WHT Calc';
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG WHT_0.1';
        }
        field(50005; "Min. WHT Calc only on Inv. Amt"; Boolean)
        {
            Caption = 'Min. WHT Calc only on Inv. Amt';
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG WHT_0.1';
        }
        field(50006; "Force Payment With Invoice"; Boolean)
        {
            Caption = 'Force Payment With Invoice';
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG WHT_0.1';
        }
        field(50007; "Round Payment Amt for WHT"; Boolean)//Pru Neha
        {
            Caption = 'Round Payment Amount for Withholding Tax';
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG WHT_0.1';
        }
        field(50008; "Shortcut Dimension 9"; code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension";
        }
        field(50009; "Shortcut Dimension 10"; code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension";
        }
    }

}

