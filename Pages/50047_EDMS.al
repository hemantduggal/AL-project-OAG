page 50047 "EDMS Log List"
{
    Caption = 'Documents Log List';
    PageType = List;
    UsageCategory = Administration;
    ApplicationArea = all;
    SourceTable = EDMSGET;
    Editable = false;
    SourceTableView = sorting(DocumentID) order(descending);

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                Caption = 'General';
                field(Databaseid; Rec.Databaseid)
                {
                    ApplicationArea = all;
                }
                field(Department; Department)
                {
                    ApplicationArea = all;
                }
                field("File Name"; Rec."File Name")
                {
                    ApplicationArea = all;
                }
                field(DocumentID; Rec.DocumentID)
                {
                    Caption = 'Document ID';
                    ApplicationArea = all;
                }
                field(documentTyp; Rec.documentTyp)
                {
                    Caption = 'Document Type';
                    ApplicationArea = all;
                }
                field(url; Rec.url)
                {
                    Visible = false;
                    Caption = 'Download';
                    ApplicationArea = all;
                    trigger OnDrillDown()
                    begin
                        hyperlink(Rec.url);
                    end;
                }
                field("Download"; download)
                {
                    ApplicationArea = all;
                    Caption = 'Download';
                    trigger OnDrillDown()
                    begin
                        hyperlink(Rec.url);
                    end;
                }
            }
        }
    }
    trigger OnOpenPage()
    var
        emdsget: Codeunit edmsintegration;
        recEdms: Record EDMSGET;

    begin
        recEdms.DeleteAll();
        emdsget.GetMethod();
    end;

    trigger OnAfterGetRecord()
    begin
        Clear(Department);
        if Rec.Databaseid = '1049' then
            Department := 'FICO'
        else
            if
       Rec.Databaseid = '1050' then
                Department := 'MM'
    end;

    var
        Department: Code[30];
        download: label 'Click here to Download';

}