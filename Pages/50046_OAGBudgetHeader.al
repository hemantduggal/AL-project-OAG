page 50046 "Oag approved test"
{
    Caption = 'OAG Budget Card';
    PageType = Card;
    UsageCategory = Administration;
    // ApplicationArea = all;
    PopulateAllFields = true;
    SourceTable = "OAG Budget Header";
    Editable = true;
    layout
    {
        area(Content)
        {
            group("General")
            {
                Caption = 'General';

                field("Budget Name"; Rec."Budget Name")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        // linesupdate();
                    end;
                }
                field(BudgetType; Rec.BudgetType)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Caption = 'Annual Budget Status';
                    trigger OnDrillDown()
                    var
                        annual: Record AnnualBudget;
                        port: XmlPort 50002;
                    begin
                        annualBudet();
                        if rec.BudgetType <> 'Submitted' then begin
                            port.Run();
                            linesupdate();
                        end
                        else begin
                            annual.Reset();
                            annual.SetRange(BudgetName, Rec."Budget Name");
                            if rec.programcode <> '' then
                                annual.SetRange(programcode, rec.programcode);
                            if rec.auditentities <> '' then
                                annual.SetRange(auditentities, rec.auditentities);
                            if rec.directorate <> '' then
                                annual.SetRange(directorate, rec.directorate);
                            if rec.funding <> '' then
                                annual.SetRange(funding, rec.funding);
                            if rec.projectfilter <> '' then
                                annual.SetRange(projectfilter, rec.projectfilter);
                            if rec.budget5 <> '' then
                                annual.SetRange(budget5, rec.projectfilter);
                            if rec.budgetoutput <> '' then
                                annual.SetRange(budgetoutput, rec.budgetoutput);
                            if annual.FindSet() then
                                page.Run(page::"Annual Budget Entry", annual);
                        end;
                    end;
                }
                field(BudgetStatus; Rec.BudgetStatus)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Caption = 'Budget Status';
                }
                field(FinancialYear; Rec.FinancialYear)
                {
                    ApplicationArea = all;
                    Caption = 'Financial Year';
                    trigger OnValidate()
                    var
                        year: Integer;
                        lines: Record BudgetLines;
                    begin
                        Evaluate(year, rec.FinancialYear);
                        Rec.datefilter := Format(year - 1) + '-07-01..' + format(year) + '-06-30';
                        rec.Modify();
                        lines.Reset();
                        lines.SetRange("Budget name", Rec."Budget Name");
                        if lines.FindSet() then
                            repeat
                                lines.datefilter := Format(year - 1) + '-07-01..' + format(year) + '-06-30';
                                lines.year := year;
                                lines.Modify();
                            until lines.Next() = 0;
                        linesupdate();
                    end;
                }
            }
            group(Lines)
            {
                part(budgetline; oagbudgetsubform)
                {
                    Editable = false;
                    SubPageLink = BudgetStatus = FIELD(BudgetStatus), "Budget Name" = field("Budget Name");
                    ApplicationArea = All;
                }
            }
            group(Filters)
            {
                field(datefilter; Rec.datefilter)
                {
                    // ExtendedDatatype = Masked;
                    // ApplicationArea = all;
                }
                field(glaccountfilter; Rec.glaccountfilter)
                {
                    // ApplicationArea = all;
                    LookupPageId = "G/L Account List";
                }
                field(glaccountcategory; Rec.glaccountcategory)
                {
                    // ApplicationArea = all;
                }
                field(incomebalance; Rec.incomebalance)
                {
                    // ApplicationArea = all;
                }
                field(programcode; Rec.programcode)
                {
                    ApplicationArea = all;
                    Caption = 'Programme Code';
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        DimensionValue: Record "Dimension Value";
                    begin
                        exit(DimensionValue.LookUpDimFilter(GLSetup."Global Dimension 1 Code", Text));
                    end;

                    trigger OnValidate()
                    begin
                        linesupdate();
                    end;
                }
                field(directorate; Rec.directorate)
                {
                    Caption = 'Directorate Code';
                    ApplicationArea = all;
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        DimensionValue: Record "Dimension Value";
                    begin
                        exit(DimensionValue.LookUpDimFilter(GLSetup."Global Dimension 2 Code", Text));
                    end;

                    trigger OnValidate()
                    begin
                        linesupdate();
                    end;
                }
                field(projectfilter; Rec.projectfilter)
                {
                    ApplicationArea = all;
                    Caption = 'Project Code';
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        DimensionValue: Record "Dimension Value";
                    begin
                        exit(DimensionValue.LookUpDimFilter(GLSetup."Shortcut Dimension 5 Code", Text));
                    end;

                    trigger OnValidate()
                    begin
                        linesupdate();
                    end;
                }
                field(budgetoutput; Rec.budgetoutput)
                {
                    ApplicationArea = all;
                    Caption = 'Budget Output';
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        DimensionValue: Record "Dimension Value";
                    begin
                        exit(DimensionValue.LookUpDimFilter(GLSetup."Shortcut Dimension 6 Code", Text));
                    end;

                    trigger OnValidate()
                    begin
                        linesupdate();
                    end;
                }
                field(auditentities; Rec.auditentities)
                {
                    Caption = 'Audit Entities';
                    ApplicationArea = all;
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        DimensionValue: Record "Dimension Value";
                    begin
                        exit(DimensionValue.LookUpDimFilter(GLSetup."Shortcut Dimension 7 Code", Text));
                    end;

                    trigger OnValidate()
                    begin
                        linesupdate();
                    end;
                }
                field(funding; Rec.funding)
                {
                    Caption = 'Funding Source';
                    ApplicationArea = all;
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        DimensionValue: Record "Dimension Value";
                    begin
                        exit(DimensionValue.LookUpDimFilter(GLSetup."Shortcut Dimension 4 Code", Text));
                    end;

                    trigger OnValidate()
                    begin
                        linesupdate();
                    end;
                }
                field(budget5; Rec.budget5)
                {
                    Caption = 'Fund Code';
                    ApplicationArea = all;
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        DimensionValue: Record "Dimension Value";
                    begin
                        exit(DimensionValue.LookUpDimFilter(GLSetup."Shortcut Dimension 3 Code", Text));
                    end;

                    trigger OnValidate()
                    begin
                        linesupdate();
                    end;
                }
                ////pru neha 3-9-23
                field(AuditAssign; Rec.AuditAssign)
                {
                    Caption = 'Audit Assignments';
                    ApplicationArea = all;
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        DimensionValue: Record "Dimension Value";
                    begin
                        exit(DimensionValue.LookUpDimFilter(GLSetup."Shortcut Dimension 8 Code", Text));
                    end;

                    trigger OnValidate()
                    begin
                        linesupdate();
                    end;
                }
                field(BudgetCategory; Rec.BudgetCategory)
                {
                    Caption = 'Budget Category';
                    ApplicationArea = all;
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        DimensionValue: Record "Dimension Value";
                    begin
                        exit(DimensionValue.LookUpDimFilter(GLSetup."Shortcut Dimension 9", Text));
                    end;

                    trigger OnValidate()
                    begin
                        linesupdate();
                    end;
                }
                /////////
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Refresh)
            {
                Image = Refresh;
                ApplicationArea = all;
                Promoted = true;
                trigger OnAction()
                begin
                    if Rec."Budget Name" <> '' then begin
                        linesupdate();
                        annualBudet();
                    end;
                end;
            }
            action(ReAllocatedLines)
            {
                Image = AllLines;
                ApplicationArea = all;
                Promoted = true;
                Caption = 'Posted Reallocated Lines';
                trigger OnAction()
                var
                    lines: Record BudgetQuater;
                begin
                    lines.Reset();
                    lines.SetRange(BudgetName, rec."Budget Name");
                    lines.SetRange(isreallocated, true);
                    if lines.FindFirst() then
                        page.RunModal(page::"Budget Quater", lines);
                end;
            }
        }
    }
    trigger OnOpenPage()

    begin
        GLSetup.get();
        if Rec."Budget Name" <> '' then begin
            linesupdate();
            annualBudet();
        end;

    end;

    procedure annualBudet()
    var
        annual: Record AnnualBudget;
    begin
        annual.Reset();
        annual.SetRange(BudgetName, rec."Budget Name");
        if annual.FindFirst() then
            rec.BudgetType := 'Submitted'
        else
            Rec.BudgetType := 'Click here to Upload';
    end;

    procedure addlines()
    var
        lines: Record BudgetLines;
        vendledger: Record "Vendor Ledger Entry";
        gl: Record "G/L Account";
        budetentry: Record BudgetQuater;
        annualbud: Record AnnualBudget;
        genjnl: Record "Gen. Journal Line";
        purchead: Record "Purchase Header";
        Pline: Record "Purchase Line";
        purinvhead: Record "Purch. Inv. Header";
        purinvline: Record "Purch. Inv. Line";
        itemrec: Record Item;
        invsetup: Record "Inventory Posting Setup";
        fromdate: date;
        todate: date;
        year: Integer;
        vendled: Record "Vendor Ledger Entry";
        glentry: Record "G/L Entry";
    begin
        gl.Reset();
        gl.SetRange("G/L Budget", true);
        if gl.FindSet() then begin
            repeat
                lines.Init();
                lines.BudgetStatus := Rec.BudgetStatus;
                lines."Budget name" := Rec."Budget Name";
                lines.code := gl."No.";
                lines.Name := gl.Name;
                if Rec.FinancialYear <> '' then
                    Evaluate(lines.year, rec.FinancialYear);
                annualbud.Reset();
                annualbud.SetRange(BudgetName, Rec."Budget Name");
                annualbud.SetRange(glacc, gl."No.");
                if rec.programcode <> '' then
                    annualbud.SetRange(programcode, rec.programcode);
                if rec.auditentities <> '' then
                    annualbud.SetRange(auditentities, rec.auditentities);
                if rec.directorate <> '' then
                    annualbud.SetRange(directorate, rec.directorate);
                if rec.funding <> '' then
                    annualbud.SetRange(funding, rec.funding);
                if rec.projectfilter <> '' then
                    annualbud.SetRange(projectfilter, rec.projectfilter);
                if rec.budget5 <> '' then
                    annualbud.SetRange(budget5, rec.projectfilter);
                if rec.budgetoutput <> '' then
                    annualbud.SetRange(budgetoutput, rec.budgetoutput);
                if annualbud.FindSet() then
                    repeat
                        // message('%1', budetentry.count);
                        lines.annualbudget += annualbud.Amount
                    until annualbud.Next() = 0;
                //q1
                purchead.Reset();
                if Rec.FinancialYear <> '' then
                    evaluate(year, rec.FinancialYear);
                evaluate(fromdate, format(year - 1) + '-07-01');
                evaluate(todate, format(year - 1) + '-10-01');
                budetentry.Reset();
                budetentry.SetRange(BudgetName, Rec."Budget Name");
                budetentry.SetRange(Quater, budetentry.Quater::Q1);
                budetentry.SetRange(Is_Supplementry, budetentry.Is_Supplementry::N);
                budetentry.SetRange(glacc, gl."No.");
                if rec.programcode <> '' then
                    budetentry.SetRange(programcode, rec.programcode);
                if rec.auditentities <> '' then
                    budetentry.SetRange(auditentities, rec.auditentities);
                if rec.directorate <> '' then
                    budetentry.SetRange(directorate, rec.directorate);
                if rec.funding <> '' then
                    budetentry.SetRange(funding, rec.funding);
                if rec.projectfilter <> '' then
                    budetentry.SetRange(projectfilter, rec.projectfilter);
                if rec.budget5 <> '' then
                    budetentry.SetRange(budget5, rec.projectfilter);
                if rec.budgetoutput <> '' then
                    budetentry.SetRange(budgetoutput, rec.budgetoutput);
                if budetentry.FindSet() then
                    repeat
                        // message('%1', budetentry.count);
                        lines.Q1 += budetentry.Amount
                    until budetentry.Next() = 0;

                //q1paym
                vendled.reset;
                vendled.SetRange("Posting Date", fromdate, todate);
                vendled.SetRange("Document Type", vendled."Document Type"::Payment);
                if vendled.FindSet() then
                    repeat
                        purinvhead.Reset();
                        purinvhead.SetRange("Vendor Invoice No.", vendled."Applies-to Ext. Doc. No.");
                        if purinvhead.FindSet() then
                            repeat
                                purinvline.Reset();
                                purinvline.SetRange("Document No.", purinvhead."No.");
                                if purinvline.FindSet() then
                                    repeat
                                        if purinvline.type = purinvline.Type::Item then begin
                                            invsetup.Reset();
                                            if invsetup.get(purinvline."Location Code", purinvline."Posting Group") then;
                                            if gl."No." = invsetup."Inventory Account" then
                                                lines.Q1paym += purinvline."Amount Including VAT";
                                        end;
                                        if purinvline.type = purinvline.Type::"G/L Account" then begin
                                            if gl."No." = purinvline."No." then
                                                lines.Q1paym += purinvline."Amount Including VAT";
                                        end;
                                    until purinvline.Next() = 0;
                            until purinvhead.Next() = 0;
                    until vendled.Next() = 0; //q1paymn end
                purchead.SetFilter(Status, '%1|%2|%3', purchead.Status::Released, purchead.Status::"Pending Approval", purchead.Status::"Pending Prepayment");
                purchead.SetRange("Posting Date", fromdate, todate);
                if purchead.FindSet() then
                    repeat
                        Pline.Reset();
                        Pline.SetRange("Document No.", purchead."No.");
                        if Pline.FindSet() then
                            repeat
                                // Message(Pline."Document No.");
                                if Pline.Type = pline.Type::"G/L Account" then
                                    if gl."No." = Pline."No." then begin
                                        // Message('ok');
                                        lines.Q1encum += pline."Amount Including VAT";
                                    end;
                                if Pline.Type = pline.type::Item then
                                    if itemrec.get(pline."No.") then begin
                                        invsetup.Reset();
                                        invsetup.SetRange("Location Code", Pline."Location Code");
                                        invsetup.SetRange("Invt. Posting Group Code", itemrec."Inventory Posting Group");
                                        if invsetup.FindFirst() then begin
                                            if gl."No." = invsetup."Inventory Account" then
                                                lines.Q1encum += pline."Amount Including VAT";
                                        end;
                                    end;
                            until Pline.Next() = 0;
                    until purchead.Next() = 0;
                //Q2
                purchead.Reset();
                clear(fromdate);
                clear(todate);
                evaluate(fromdate, format(year - 1) + '-10-01');
                evaluate(todate, format(year) + '-01-01');
                budetentry.Reset();
                budetentry.SetRange(BudgetName, Rec."Budget Name");
                budetentry.SetRange(Quater, budetentry.Quater::Q2);
                budetentry.SetRange(Is_Supplementry, budetentry.Is_Supplementry::N);
                budetentry.SetRange(glacc, gl."No.");
                if rec.programcode <> '' then
                    budetentry.SetRange(programcode, rec.programcode);
                if rec.auditentities <> '' then
                    budetentry.SetRange(auditentities, rec.auditentities);
                if rec.directorate <> '' then
                    budetentry.SetRange(directorate, rec.directorate);
                if rec.funding <> '' then
                    budetentry.SetRange(funding, rec.funding);
                if rec.projectfilter <> '' then
                    budetentry.SetRange(projectfilter, rec.projectfilter);
                if rec.budget5 <> '' then
                    budetentry.SetRange(budget5, rec.projectfilter);
                if rec.budgetoutput <> '' then
                    budetentry.SetRange(budgetoutput, rec.budgetoutput);
                if budetentry.FindSet() then
                    repeat
                        // message('%1', budetentry.count);
                        lines.Q2 += budetentry.Amount
                    until budetentry.Next() = 0;

                // glentry.Reset();
                // glentry.SetRange("Posting Date", fromdate, todate);
                // glentry.SetRange("G/L Account No.", gl."No.");
                // glentry.SetRange("Document Type", glentry."Document Type"::Payment);
                // // glentry.SetRange("Document No.", vendledger."Document No.");
                // if glentry.FindSet() then
                //     repeat
                //         lines.Q2paym += ABS(glentry.Amount);
                //     until glentry.Next() = 0;

                vendled.reset;
                vendled.SetRange("Posting Date", fromdate, todate);
                vendled.SetRange("Document Type", vendled."Document Type"::Payment);
                if vendled.FindSet() then
                    repeat
                        purinvhead.Reset();
                        purinvhead.SetRange("Vendor Invoice No.", vendled."Applies-to Ext. Doc. No.");
                        if purinvhead.FindSet() then
                            repeat
                                purinvline.Reset();
                                purinvline.SetRange("Document No.", purinvhead."No.");
                                if purinvline.FindSet() then
                                    repeat
                                        if purinvline.type = purinvline.Type::Item then begin
                                            invsetup.Reset();
                                            if invsetup.get(purinvline."Location Code", purinvline."Posting Group") then;
                                            if gl."No." = invsetup."Inventory Account" then
                                                lines.Q2paym += purinvline."Amount Including VAT";
                                        end;
                                        if purinvline.type = purinvline.Type::"G/L Account" then begin
                                            if gl."No." = purinvline."No." then
                                                lines.Q2paym += purinvline."Amount Including VAT";
                                        end;
                                    until purinvline.Next() = 0;
                            until purinvhead.Next() = 0;
                    until vendled.Next() = 0;
                //paymnq2
                purchead.SetFilter(Status, '%1|%2|%3', purchead.Status::Released, purchead.Status::"Pending Approval", purchead.Status::"Pending Prepayment");
                purchead.SetRange("Posting Date", fromdate, todate);
                if purchead.FindSet() then
                    repeat
                        Pline.Reset();
                        Pline.SetRange("Document No.", purchead."No.");
                        if Pline.FindSet() then
                            repeat
                                // Message(Pline."Document No.");
                                if Pline.Type = pline.Type::"G/L Account" then
                                    if gl."No." = Pline."No." then begin
                                        // Message('ok');
                                        lines.Q2encum += pline."Amount Including VAT";
                                    end;
                                if Pline.Type = pline.type::Item then
                                    if itemrec.get(pline."No.") then begin
                                        invsetup.Reset();
                                        invsetup.SetRange("Location Code", Pline."Location Code");
                                        invsetup.SetRange("Invt. Posting Group Code", itemrec."Inventory Posting Group");
                                        if invsetup.FindFirst() then begin
                                            if gl."No." = invsetup."Inventory Account" then
                                                lines.Q2encum += pline."Amount Including VAT";
                                        end;
                                    end;
                            until Pline.Next() = 0;
                    until purchead.Next() = 0;
                //Q3
                purchead.Reset();
                clear(fromdate);
                clear(todate);
                evaluate(fromdate, format(year) + '-01-01');
                evaluate(todate, format(year) + '-04-01');
                budetentry.Reset();
                budetentry.SetRange(BudgetName, Rec."Budget Name");
                budetentry.SetRange(Quater, budetentry.Quater::Q3);
                budetentry.SetRange(Is_Supplementry, budetentry.Is_Supplementry::N);
                budetentry.SetRange(glacc, gl."No.");
                if rec.programcode <> '' then
                    budetentry.SetRange(programcode, rec.programcode);
                if rec.auditentities <> '' then
                    budetentry.SetRange(auditentities, rec.auditentities);
                if rec.directorate <> '' then
                    budetentry.SetRange(directorate, rec.directorate);
                if rec.funding <> '' then
                    budetentry.SetRange(funding, rec.funding);
                if rec.projectfilter <> '' then
                    budetentry.SetRange(projectfilter, rec.projectfilter);
                if rec.budget5 <> '' then
                    budetentry.SetRange(budget5, rec.projectfilter);
                if rec.budgetoutput <> '' then
                    budetentry.SetRange(budgetoutput, rec.budgetoutput);
                if budetentry.FindSet() then
                    repeat
                        // message('%1', budetentry.count);
                        lines.Q3 += budetentry.Amount
                    until budetentry.Next() = 0;

                // glentry.Reset();
                // glentry.SetRange("Posting Date", fromdate, todate);
                // glentry.SetRange("G/L Account No.", gl."No.");
                // glentry.SetRange("Document Type", glentry."Document Type"::Payment);
                // // glentry.SetRange("Document No.", vendledger."Document No.");
                // if glentry.FindSet() then
                //     repeat
                //         lines.Q3paym += ABS(glentry.Amount);
                //     until glentry.Next() = 0;

                vendled.reset;
                vendled.SetRange("Posting Date", fromdate, todate);
                vendled.SetRange("Document Type", vendled."Document Type"::Payment);
                if vendled.FindSet() then
                    repeat
                        purinvhead.Reset();
                        purinvhead.SetRange("Vendor Invoice No.", vendled."Applies-to Ext. Doc. No.");
                        if purinvhead.FindSet() then
                            repeat
                                purinvline.Reset();
                                purinvline.SetRange("Document No.", purinvhead."No.");
                                if purinvline.FindSet() then
                                    repeat
                                        if purinvline.type = purinvline.Type::Item then begin
                                            invsetup.Reset();
                                            if invsetup.get(purinvline."Location Code", purinvline."Posting Group") then;
                                            if gl."No." = invsetup."Inventory Account" then
                                                lines.Q3paym += purinvline."Amount Including VAT";
                                        end;
                                        if purinvline.type = purinvline.Type::"G/L Account" then begin
                                            if gl."No." = purinvline."No." then
                                                lines.Q3paym += purinvline."Amount Including VAT";
                                        end;
                                    until purinvline.Next() = 0;
                            until purinvhead.Next() = 0;
                    until vendled.Next() = 0;
                //q3paym

                purchead.SetFilter(Status, '%1|%2|%3', purchead.Status::Released, purchead.Status::"Pending Approval", purchead.Status::"Pending Prepayment");
                purchead.SetRange("Posting Date", fromdate, todate);
                if purchead.FindSet() then
                    repeat
                        Pline.Reset();
                        Pline.SetRange("Document No.", purchead."No.");
                        if Pline.FindSet() then
                            repeat
                                // Message(Pline."Document No.");
                                if Pline.Type = pline.Type::"G/L Account" then
                                    if gl."No." = Pline."No." then begin
                                        // Message('ok');
                                        lines.Q3encum += Pline."Amount Including VAT";
                                    end;
                                if Pline.Type = pline.type::Item then
                                    if itemrec.get(pline."No.") then begin
                                        invsetup.Reset();
                                        invsetup.SetRange("Location Code", Pline."Location Code");
                                        invsetup.SetRange("Invt. Posting Group Code", itemrec."Inventory Posting Group");
                                        if invsetup.FindFirst() then begin
                                            if gl."No." = invsetup."Inventory Account" then
                                                lines.Q3encum += Pline."Amount Including VAT";
                                        end;
                                    end;
                            until Pline.Next() = 0;
                    until purchead.Next() = 0;
                //Q4
                purchead.Reset();
                clear(fromdate);
                clear(todate);
                evaluate(fromdate, format(year) + '-04-01');
                evaluate(todate, format(year) + '-07-01');
                budetentry.Reset();
                budetentry.SetRange(BudgetName, Rec."Budget Name");
                budetentry.SetRange(Quater, budetentry.Quater::Q4);
                budetentry.SetRange(Is_Supplementry, budetentry.Is_Supplementry::N);
                budetentry.SetRange(glacc, gl."No.");
                if rec.programcode <> '' then
                    budetentry.SetRange(programcode, rec.programcode);
                if rec.auditentities <> '' then
                    budetentry.SetRange(auditentities, rec.auditentities);
                if rec.directorate <> '' then
                    budetentry.SetRange(directorate, rec.directorate);
                if rec.funding <> '' then
                    budetentry.SetRange(funding, rec.funding);
                if rec.projectfilter <> '' then
                    budetentry.SetRange(projectfilter, rec.projectfilter);
                if rec.budget5 <> '' then
                    budetentry.SetRange(budget5, rec.projectfilter);
                if rec.budgetoutput <> '' then
                    budetentry.SetRange(budgetoutput, rec.budgetoutput);
                if budetentry.FindSet() then
                    repeat
                        // message('%1', budetentry.count);
                        lines.Q4 += budetentry.Amount
                    until budetentry.Next() = 0;

                // glentry.Reset();
                // glentry.SetRange("Posting Date", fromdate, todate);
                // glentry.SetRange("G/L Account No.", gl."No.");
                // glentry.SetRange("Document Type", glentry."Document Type"::Payment);
                // // glentry.SetRange("Document No.", vendledger."Document No.");
                // if glentry.FindSet() then
                //     repeat
                //         lines.Q4paym += ABS(glentry.Amount);
                //     until glentry.Next() = 0;

                vendled.reset;
                vendled.SetRange("Posting Date", fromdate, todate);
                vendled.SetRange("Document Type", vendled."Document Type"::Payment);
                if vendled.FindSet() then
                    repeat
                        purinvhead.Reset();
                        purinvhead.SetRange("Vendor Invoice No.", vendled."Applies-to Ext. Doc. No.");
                        if purinvhead.FindSet() then
                            repeat
                                purinvline.Reset();
                                purinvline.SetRange("Document No.", purinvhead."No.");
                                if purinvline.FindSet() then
                                    repeat
                                        if purinvline.type = purinvline.Type::Item then begin
                                            invsetup.Reset();
                                            if invsetup.get(purinvline."Location Code", purinvline."Posting Group") then;
                                            if gl."No." = invsetup."Inventory Account" then
                                                lines.Q4paym += purinvline."Amount Including VAT";
                                        end;
                                        if purinvline.type = purinvline.Type::"G/L Account" then begin
                                            if gl."No." = purinvline."No." then
                                                lines.Q4paym += purinvline."Amount Including VAT";
                                        end;
                                    until purinvline.Next() = 0;
                            until purinvhead.Next() = 0;
                    until vendled.Next() = 0;
                //q4paym


                purchead.SetFilter(Status, '%1|%2|%3', purchead.Status::Released, purchead.Status::"Pending Approval", purchead.Status::"Pending Prepayment");
                purchead.SetRange("Posting Date", fromdate, todate);
                if purchead.FindSet() then
                    repeat
                        Pline.Reset();
                        Pline.SetRange("Document No.", purchead."No.");
                        if Pline.FindSet() then
                            repeat
                                // Message(Pline."Document No.");
                                if Pline.Type = pline.Type::"G/L Account" then
                                    if gl."No." = Pline."No." then begin
                                        // Message('ok');
                                        lines.Q4encum += Pline."Amount Including VAT";
                                    end;
                                if Pline.Type = pline.type::Item then
                                    if itemrec.get(pline."No.") then begin
                                        invsetup.Reset();
                                        invsetup.SetRange("Location Code", Pline."Location Code");
                                        invsetup.SetRange("Invt. Posting Group Code", itemrec."Inventory Posting Group");
                                        if invsetup.FindFirst() then begin
                                            if gl."No." = invsetup."Inventory Account" then
                                                lines.Q4encum += Pline."Amount Including VAT";
                                        end;
                                    end;
                            until Pline.Next() = 0;
                    until purchead.Next() = 0;
                //ecumend
                budetentry.Reset();
                budetentry.SetRange(BudgetName, Rec."Budget Name");
                budetentry.SetRange(Is_Supplementry, budetentry.Is_Supplementry::Y);
                budetentry.SetRange(glacc, gl."No.");
                if budetentry.FindSet() then
                    repeat
                        // message('%1', budetentry.count);
                        lines.supplementry += budetentry.Amount
                    until budetentry.Next() = 0;
                lines.warrents := lines.Q1 + lines.Q2 + lines.Q3 + lines.Q4 + lines.supplementry - lines.Q1encum - lines.Q2encum - lines.Q3encum - lines.Q4encum;
                lines.totalencum := lines.Q1encum + lines.Q2encum + lines.Q3encum + lines.Q4encum;
                lines.totalpay := lines.Q1paym + lines.Q2paym + lines.Q3paym + lines.Q4paym;
                lines.Insert();
            until gl.Next() = 0;
            CurrPage.Update();
        end;
    end;

    procedure linesupdate()
    var
        lines: Record BudgetLines;
        vendledger: Record "Vendor Ledger Entry";
        gl: Record "G/L Account";
        budetentry: Record BudgetQuater;
        annualbud: Record AnnualBudget;
        genjnl: Record "Gen. Journal Line";
        purchead: Record "Purchase Header";
        Pline: Record "Purchase Line";
        itemrec: Record Item;
        invsetup: Record "Inventory Posting Setup";
        fromdate: date;
        todate: date;
        year: Integer;
        glentry: Record "G/L Entry";
    begin
        lines.Reset();
        // lines.SetRange(BudgetStatus, Rec.BudgetStatus);
        lines.SetRange("Budget name", rec."Budget Name");
        if lines.FindSet() then begin
            lines.DeleteAll();
            addlines();
        end
        else begin
            addlines();
        end;
    end;

    var
        GLSetup: Record "General Ledger Setup";
        Label1: Text[100];
}