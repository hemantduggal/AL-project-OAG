page 50022 "WHT Product Posting Group"
{
    ApplicationArea = All;
    Caption = 'WHT Product Posting Group';
    //ModifyAllowed = false;
    PageType = List;
    SourceTable = 50008;
    UsageCategory = Lists;
    //DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(grp)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a code for the posting group.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a description for the WHT Product posting group.';
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
                RunObject = Page 50024; //Pru Neha
                RunPageLink = "WHT Product Posting Group" = FIELD(Code); //Pru Neha
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
                IF (UserSetup."WHT product Posting Group" = UserSetup."WHT product Posting Group"::" ") THEN
                    ERROR('You do not have permission to open WHT Business Posting Group');

                IF (UserSetup."WHT product Posting Group" = UserSetup."WHT product Posting Group"::View) THEN
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
                IF (UserSetup."WHT product Posting Group" = UserSetup."WHT product Posting Group"::View) THEN
                    CurrPage.EDITABLE(FALSE);

                IF (UserSetup."WHT product Posting Group" = UserSetup."WHT product Posting Group"::Edit) THEN
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
                IF (UserSetup."WHT product Posting Group" = UserSetup."WHT product Posting Group"::View) THEN
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
                IF (UserSetup."WHT product Posting Group" = UserSetup."WHT product Posting Group"::View) THEN
                    ERROR('You can not delete the record');
            END;
        END;
        //<<BCF_0.1 PRU_RPG
    end;
*/

}

