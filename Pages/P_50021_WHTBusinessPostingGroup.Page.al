page 50021 "WHT Business Posting Group"
{
    ApplicationArea = All;
    Caption = 'WHT Business Posting Group';
    //DeleteAllowed = false;
    PageType = List;
    SourceTable = 50007;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(grp)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a code for the group.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a description for the WHT business posting group.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("&Setup")
            {
                ApplicationArea = Basic, Suite;
                Caption = '&Setup';
                Image = Setup;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page 50027;
                RunPageLink = "Buy-from Vendor No." = FIELD(Code);
                ToolTip = 'View or edit the withholding tax (WHT) posting setup information. This includes posting groups, revenue types, and accounts.';
            }
        }
    }
    /*
    trigger OnDeleteRecord(): Boolean
    begin
        OnDeleteCustomizedCode;  //BCF_0.1 PRU_RPG
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        OnNewPageCustomizedCode;  //BCF_0.1 PRU_RPG
    end;

    trigger OnModifyRecord(): Boolean
    begin
        OnModifyCustomizedCode;  //BCF_0.1 PRU_RPG
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnNewPageCustomizedCode;  //BCF_0.1 PRU_RPG
    end;

    trigger OnOpenPage()
    begin
        OnOpenPageCustomizedCode;  //BCF_0.1 PRU_RPG
    end;

    local procedure OnOpenPageCustomizedCode()
    var
        UserSetup: Record 91;
    begin
        //>>>BCF_0.1 PRU_RPG
        IF UserSetup.GET(USERID) THEN BEGIN
            UserSetup.GET(USERID);
            IF (UserSetup."HO Users" = FALSE) THEN BEGIN
                Rec.FILTERGROUP(2);
                UserSetup.TESTFIELD("Business Unit");
                //  Rec.SETFILTER("Global Dimension 1 Code", '%1|%2', UserSetup."Business Unit", '');
                // Rec.FILTERGROUP(0);
                IF (UserSetup."WHT Business Posting Group" = UserSetup."WHT Business Posting Group"::" ") THEN
                    ERROR('You do not have permission to open WHT Business Posting Group');

                IF (UserSetup."Access Parameter List" = UserSetup."WHT Business Posting Group"::View) THEN
                    CurrPage.EDITABLE(FALSE)
            END;
        END;
        //<<BCF_0.1 PRU_RPG
    end;

    local procedure OnNewPageCustomizedCode()
    var
        UserSetup: Record 91;
    begin
        //>>BCF_0.1 PRU_RPG
        IF UserSetup.GET(USERID) THEN BEGIN
            IF (UserSetup."HO Users" = FALSE) THEN BEGIN
                IF (UserSetup."WHT Business Posting Group" = UserSetup."WHT Business Posting Group"::View) THEN
                    CurrPage.EDITABLE(FALSE);

                IF (UserSetup."WHT Business Posting Group" = UserSetup."WHT Business Posting Group"::Edit) THEN
                    ERROR('You do not have permission to create Parameter List');
            END;
        END;
        //<<BCF_0.1 PRU_RPG
    end;

    local procedure OnModifyCustomizedCode()
    var
        UserSetup: Record 91;
    begin
        //>>BCF_0.1 PRU_RPG
        IF UserSetup.GET(USERID) THEN BEGIN
            IF (UserSetup."HO Users" = FALSE) THEN BEGIN
                IF (UserSetup."WHT Business Posting Group" = UserSetup."WHT Business Posting Group"::View) THEN
                    ERROR('You can not modify the record');
            END;
        END;
        //<<BCF_0.1 PRU_RPG
    end;

    local procedure OnDeleteCustomizedCode()
    var
        UserSetup: Record 91;
    begin
        //>>BCF_0.1 PRU_RPG
        IF UserSetup.GET(USERID) THEN BEGIN
            IF (UserSetup."HO Users" = FALSE) THEN BEGIN
                IF (UserSetup."WHT Business Posting Group" = UserSetup."WHT Business Posting Group"::View) THEN
                    ERROR('You can not delete the record');
            END;
        END;
        //<<BCF_0.1 PRU_RPG
    end;
*/

}

