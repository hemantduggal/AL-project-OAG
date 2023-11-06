page 50020 "EmployeeList_APIs"
{
    Caption = 'Employee List APIs';
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Employee,Navigate';
    SourceTable = Employee;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Importance = Standard;
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                    Visible = NoFieldVisible;

                    trigger OnAssistEdit()
                    begin
                        // AssistEdit;
                    end;
                }
                field("First Name"; rec."First Name")
                {
                    ApplicationArea = BasicHR;
                    Importance = Promoted;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the employee''s first name.';
                }
                field("Middle Name"; rec."Middle Name")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the employee''s middle name.';
                }
                field("Last Name"; rec."Last Name")
                {
                    ApplicationArea = BasicHR;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the employee''s last name.';
                }
                field("Job Title"; rec."Job Title")
                {
                    ApplicationArea = BasicHR;
                    Importance = Promoted;
                    ToolTip = 'Specifies the employee''s job title.';
                }
                field(Initials; rec.Initials)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the employee''s initials.';
                }
                field("Search Name"; rec."Search Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies an alternate name that you can use to search for the record in question when you cannot remember the value in the Name field.';
                }
                field(Gender; rec.Gender)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the employee''s gender.';
                }
                field("Phone No.2"; rec."Phone No.")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Company Phone No.';
                    ToolTip = 'Specifies the employee''s telephone number.';
                }
                field("Company E-Mail"; rec."Company E-Mail")
                {
                    ApplicationArea = BasicHR;
                    ExtendedDatatype = EMail;
                    ToolTip = 'Specifies the employee''s email address at the company.';
                }
                field("Last Date Modified"; rec."Last Date Modified")
                {
                    ApplicationArea = BasicHR;
                    Importance = Additional;
                    ToolTip = 'Specifies when this record was last modified.';
                }
                field("Privacy Blocked"; rec."Privacy Blocked")
                {
                    ApplicationArea = BasicHR;
                    Importance = Additional;
                    ToolTip = 'Specifies whether to limit access to data for the data subject during daily operations. This is useful, for example, when protecting data from changes while it is under privacy review.';
                }
            }
            group("Address & Contact")
            {
                Caption = 'Address & Contact';
                group(Control13)
                {
                    ShowCaption = false;
                    field(Address; rec.Address)
                    {
                        ApplicationArea = BasicHR;
                        ToolTip = 'Specifies the employee''s address.';
                    }
                    field("Address 2"; rec."Address 2")
                    {
                        ApplicationArea = BasicHR;
                        ToolTip = 'Specifies additional address information.';
                    }
                    field(City; rec.City)
                    {
                        ApplicationArea = BasicHR;
                        ToolTip = 'Specifies the city of the address.';
                    }
                    group(Control31)
                    {
                        ShowCaption = false;
                        Visible = IsCountyVisible;
                        field(County; rec.County)
                        {
                            ApplicationArea = BasicHR;
                            ToolTip = 'Specifies the county of the employee.';
                        }
                    }
                    field("Post Code"; rec."Post Code")
                    {
                        ApplicationArea = BasicHR;
                        ToolTip = 'Specifies the postal code.';
                    }
                    field("Country/Region Code"; rec."Country/Region Code")
                    {
                        ApplicationArea = BasicHR;
                        ToolTip = 'Specifies the country/region of the address.';

                        trigger OnValidate()
                        begin
                            IsCountyVisible := FormatAddress.UseCounty(rec."Country/Region Code");
                        end;
                    }
                    field(ShowMap; ShowMapLbl)
                    {
                        ApplicationArea = BasicHR;
                        Editable = false;
                        ShowCaption = false;
                        Style = StrongAccent;
                        StyleExpr = TRUE;
                        ToolTip = 'Specifies the employee''s address on your preferred online map.';

                        trigger OnDrillDown()
                        begin
                            CurrPage.Update(true);
                            //DisplayMap;
                        end;
                    }
                }
                group(Control7)
                {
                    ShowCaption = false;
                    field("Mobile Phone No."; rec."Mobile Phone No.")
                    {
                        ApplicationArea = BasicHR;
                        Caption = 'Private Phone No.';
                        Importance = Promoted;
                        ToolTip = 'Specifies the employee''s private telephone number.';
                    }
                    field(Pager; rec.Pager)
                    {
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Specifies the employee''s pager number.';
                    }
                    field(Extension; rec.Extension)
                    {
                        ApplicationArea = BasicHR;
                        Importance = Promoted;
                        ToolTip = 'Specifies the employee''s telephone extension.';
                    }
                    field("Phone No."; rec."Phone No.")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Direct Phone No.';
                        Importance = Promoted;
                        ToolTip = 'Specifies the employee''s telephone number.';
                    }
                    field("E-Mail"; rec."E-Mail")
                    {
                        ApplicationArea = BasicHR;
                        Caption = 'Private Email';
                        Importance = Promoted;
                        ToolTip = 'Specifies the employee''s private email address.';
                    }
                    field("Alt. Address Code"; rec."Alt. Address Code")
                    {
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Specifies a code for an alternate address.';
                    }
                    field("Alt. Address Start Date"; rec."Alt. Address Start Date")
                    {
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Specifies the starting date when the alternate address is valid.';
                    }
                    field("Alt. Address End Date"; rec."Alt. Address End Date")
                    {
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Specifies the last day when the alternate address is valid.';
                    }
                }
            }
            group(Administration)
            {
                Caption = 'Administration';
                field("Employment Date"; rec."Employment Date")
                {
                    ApplicationArea = BasicHR;
                    Importance = Promoted;
                    ToolTip = 'Specifies the date when the employee began to work for the company.';
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = BasicHR;
                    Importance = Promoted;
                    ToolTip = 'Specifies the employment status of the employee.';
                }
                field("Inactive Date"; rec."Inactive Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the date when the employee became inactive, due to disability or maternity leave, for example.';
                }
                field("Cause of Inactivity Code"; rec."Cause of Inactivity Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies a code for the cause of inactivity by the employee.';
                }
                field("Termination Date"; rec."Termination Date")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the date when the employee was terminated, due to retirement or dismissal, for example.';
                }
                field("Grounds for Term. Code"; rec."Grounds for Term. Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies a termination code for the employee who has been terminated.';
                }
                field("Emplymt. Contract Code"; rec."Emplymt. Contract Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the employment contract code for the employee.';
                }
                field("Statistics Group Code"; rec."Statistics Group Code")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies a statistics group code to assign to the employee for statistical purposes.';
                }
                field("Resource No."; rec."Resource No.")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies a resource number for the employee.';
                }
                field("Salespers./Purch. Code"; rec."Salespers./Purch. Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies a salesperson or purchaser code for the employee.';
                }
            }
            group(Personal)
            {
                Caption = 'Personal';
                field("Birth Date"; rec."Birth Date")
                {
                    ApplicationArea = BasicHR;
                    Importance = Promoted;
                    ToolTip = 'Specifies the employee''s date of birth.';
                }
                field("Social Security No."; rec."Social Security No.")
                {
                    ApplicationArea = BasicHR;
                    Importance = Promoted;
                    ToolTip = 'Specifies the social security number of the employee.';
                }
                field("Union Code"; rec."Union Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the employee''s labor union membership code.';
                }
                field("Union Membership No."; rec."Union Membership No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the employee''s labor union membership number.';
                }
            }
            group(Payments)
            {
                Caption = 'Payments';
                field("Employee Posting Group"; rec."Employee Posting Group")
                {
                    ApplicationArea = BasicHR;
                    LookupPageID = "Employee Posting Groups";
                    ToolTip = 'Specifies the employee''s type to link business transactions made for the employee with the appropriate account in the general ledger.';
                }
                field("Application Method"; rec."Application Method")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies how to apply payments to entries for this employee.';
                }
                field("Bank Branch No."; rec."Bank Branch No.")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies a number of the bank branch.';
                }
                field("Bank Account No."; rec."Bank Account No.")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the number used by the bank for the bank account.';
                }
                field(IBAN; rec.IBAN)
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the bank account''s international bank account number.';
                }
                field("SWIFT Code"; rec."SWIFT Code")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the SWIFT code (international bank identifier code) of the bank where the employee has the account.';
                }
            }
        }
        area(factboxes)
        {
            part(Control3; "Employee Picture")
            {
                ApplicationArea = BasicHR;
                SubPageLink = "No." = FIELD("No.");
            }
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(5200),
                              "No." = FIELD("No.");
            }
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
                Visible = true;
            }
        }
    }


    var
        ShowMapLbl: Label 'Show on Map';
        FormatAddress: Codeunit "Format Address";
        NoFieldVisible: Boolean;
        IsCountyVisible: Boolean;
        NewMode: Boolean;

    local procedure SetNoFieldVisible()
    var
        DocumentNoVisibility: Codeunit DocumentNoVisibility;
    begin
        NoFieldVisible := DocumentNoVisibility.EmployeeNoIsVisible();
    end;
}

