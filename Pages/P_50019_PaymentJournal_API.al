page 50019 PaymentJournal_API
{
    AdditionalSearchTerms = 'print check,payment file export,electronic payment';
    ApplicationArea = Basic, Suite;
    AutoSplitKey = true;
    Caption = 'Payment Journals API';
    //DataCaptionExpression = DataCaption;
    SourceTableView = WHERE("Journal Batch Name" = CONST('PAYROLL'), "Journal Template Name" = const('BANK PAY'));
    DelayedInsert = true;
    PageType = Worksheet;
    PromotedActionCategories = 'New,Process,Report,Bank,Prepare,Approve,Page,Post/Print,Line,Account,Check';
    SaveValues = true;
    SourceTable = "Gen. Journal Line";
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {

            repeater(Control1)
            {
                ShowCaption = false;
                field("Journal Template Name"; Rec."Journal Template Name")
                {
                    ApplicationArea = all;
                }
                field("Journal Batch Name"; Rec."Journal Batch Name")
                {
                    ApplicationArea = all;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = all;
                }
                field("Document Type"; Rec."Document Type"::Invoice)
                {
                    ApplicationArea = all;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        Rec."Journal Template Name" := 'BANK PAY';
                        Rec."Journal Batch Name" := 'PAYROLL';
                    end;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = all;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = all;
                }

                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = all;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = all;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = all;
                }
                field("Bal. Account Type"; Rec."Bal. Account Type")
                {
                    ApplicationArea = all;
                }
                field("Bal. Account No."; Rec.bankaccount)
                {
                    ApplicationArea = all;
                }
                field(PRDH_ID; Rec.PRDH_ID)
                {
                    ApplicationArea = all;
                }
                field(PR_MONTH; Rec.PR_MONTH)
                {
                    ApplicationArea = all;
                }
                field(PR_YEAR; Rec.PR_YEAR)
                {
                    ApplicationArea = all;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                }
                field(EmpId; Rec.EmpId)
                {
                    ApplicationArea = all;
                }
                field(Vote; Rec.Vote)
                {
                    ApplicationArea = all;
                }
                field(TINNumber; Rec.TINNumber)
                {
                    ApplicationArea = all;
                }
                field(SupplierNo; Rec.SupplierNo)
                {
                    ApplicationArea = all;
                }
                field(NSSFNo; Rec.NSSFNo)
                {
                    ApplicationArea = all;
                }
                field(ProgrammeCode; Rec.ProgrammeCode)
                {
                    ApplicationArea = all;
                }
                field(PayrollNames; Rec.PayrollNames)
                {
                    ApplicationArea = all;
                }
                field(IFMSNames; Rec.IFMSNames)
                {
                    ApplicationArea = all;
                }
                field(Title; Rec.Title)
                {
                    ApplicationArea = all;
                }
                field(IFMSAccNo; Rec.IFMSAccNo)
                {
                    ApplicationArea = all;
                }
                field(SalaryAccNo; Rec.SalaryAccNo)
                {
                    ApplicationArea = all;
                }
                field(PayScale; Rec.PayScale)
                {
                    ApplicationArea = all;
                }
                field(GrossPay; Rec.GrossPay)
                {
                    ApplicationArea = all;
                }
                field(BasicPay; Rec.BasicPay)
                {
                    ApplicationArea = all;
                }
                field(TaxableArreas; Rec.TaxableArreas)
                {
                    ApplicationArea = all;
                }
                field(TotalBasicPay; Rec.TotalBasicPay)
                {
                    ApplicationArea = all;
                }
                field(Paye; Rec.Paye)
                {
                    ApplicationArea = all;
                }
                field(NSSF; Rec.NSSF)
                {
                    ApplicationArea = all;
                }
                field(LST; Rec.LST)
                {
                    ApplicationArea = all;
                }
                field(NetPay; Rec.NetPay)
                {
                    ApplicationArea = all;
                }
                field("Employment Type"; Rec."Employment Type")
                {
                    ApplicationArea = all;
                }
                field("Sacco Deduction"; Rec."Sacco Deduction")
                {
                    ApplicationArea = all;
                }
                field("Computer No"; Rec."Computer No")
                {
                    ApplicationArea = all;
                }
            }
        }
    }
    trigger OnInit()
    begin
        Rec."Journal Template Name" := 'BANK PAY';
        Rec."Journal Batch Name" := 'PAYROLL';
        Rec.Validate("Account Type", Rec."Account Type"::Employee);
        Rec.Validate("Bal. Account Type", Rec."Bal. Account Type"::"Bank Account");
    end;

    var
        Text000: Label 'Void Check %1?';
        Text001: Label 'Void all printed checks?';
        GeneratingPaymentsMsg: Label 'Generating Payment file...';
        GeneralLedgerSetup: Record "General Ledger Setup";
        GenJnlLine: Record "Gen. Journal Line";
        GenJnlLine2: Record "Gen. Journal Line";
        GenJnlManagement: Codeunit GenJnlManagement;
        ReportPrint: Codeunit "Test Report-Print";
        DocPrint: Codeunit "Document-Print";
        CheckManagement: Codeunit CheckManagement;
        JournalErrorsMgt: Codeunit "Journal Errors Mgt.";
        BackgroundErrorHandlingMgt: Codeunit "Background Error Handling Mgt.";
        ChangeExchangeRate: Page "Change Exchange Rate";
        GLReconcile: Page Reconciliation;
        CurrentJnlBatchName: Code[10];
        AccName: Text[100];
        BalAccName: Text[100];
        Balance: Decimal;
        TotalBalance: Decimal;
        NumberOfRecords: Integer;
        ShowBalance: Boolean;
        ShowTotalBalance: Boolean;
        HasPmtFileErr: Boolean;
        [InDataSet]
        BalanceVisible: Boolean;
        [InDataSet]
        TotalBalanceVisible: Boolean;
        StyleTxt: Text;
        OverdueWarningText: Text;
        EventFilter: Text;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExistForCurrUserBatch: Boolean;
        OpenApprovalEntriesOnJnlBatchExist: Boolean;
        OpenApprovalEntriesOnJnlLineExist: Boolean;
        OpenApprovalEntriesOnBatchOrCurrJnlLineExist: Boolean;
        OpenApprovalEntriesOnBatchOrAnyJnlLineExist: Boolean;
        ShowWorkflowStatusOnBatch: Boolean;
        ShowWorkflowStatusOnLine: Boolean;
        CanCancelApprovalForJnlBatch: Boolean;
        CanCancelApprovalForJnlLine: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        IsAllowPaymentExport: Boolean;
        IsSaaSExcelAddinEnabled: Boolean;
        RecipientBankAccountMandatory: Boolean;
        CanRequestFlowApprovalForBatch: Boolean;
        CanRequestFlowApprovalForBatchAndAllLines: Boolean;
        CanRequestFlowApprovalForBatchAndCurrentLine: Boolean;
        CanCancelFlowApprovalForBatch: Boolean;
        CanCancelFlowApprovalForLine: Boolean;
        AmountVisible: Boolean;
        IsSaaS: Boolean;
        DebitCreditVisible: Boolean;
        JobQueuesUsed: Boolean;
        JobQueueVisible: Boolean;
        BackgroundErrorCheck: Boolean;
        ShowAllLinesEnabled: Boolean;

    protected var
        ShortcutDimCode: array[8] of Code[20];
        DimVisible1: Boolean;
        DimVisible2: Boolean;
        DimVisible3: Boolean;
        DimVisible4: Boolean;
        DimVisible5: Boolean;
        DimVisible6: Boolean;
        DimVisible7: Boolean;
        DimVisible8: Boolean;
        ApplyEntriesActionEnabled: Boolean;


}