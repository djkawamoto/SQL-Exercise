USE library_system;

--1. How many copies of the book titled The Lost Tribe are owned by the library branch whose name is"Sharpstown"?
--[DONE]
SELECT b.Title AS 'Book Title', bc.NoOfCopies AS Copies, lb.BranchName AS 'Library Branch'
FROM book b
INNER JOIN book_copies bc ON b.BookId=bc.BookId
INNER JOIN library_branch lb ON bc.BranchId=lb.BranchId
WHERE b.Title='The Lost Tribe' AND lb.BranchName='Sharpstown';

--2. How many copies of the book titled The Lost Tribe are owned by each library branch?
--[DONE]
SELECT b.Title AS 'Book Title', bc.NoOfCopies AS '# of Copies', lb.BranchName AS 'Library Branch'
FROM book b
INNER JOIN book_copies bc ON b.BookId=bc.BookId
INNER JOIN library_branch lb ON bc.BranchId=lb.BranchId
WHERE b.Title='The Lost Tribe';

--3. Retrieve the names of all borrowers who do not have any books checked out.
--[DONE]
SELECT brw.Name
FROM borrower brw
LEFT JOIN book_loans bl ON brw.CardNo=bl.CardNo
WHERE bl.CardNo IS NULL;

--4. For each book that is loaned out from the "Sharpstown" branch and whose DueDate is today,
--retrieve the book title, the borrower's name, and the borrower's address.
--[]
--SELECT b.Title, brw.Name, brw.Address
--FROM borrower
--INNER JOIN book b ON b.BookId=

--5. For each library branch, retrieve the branch name and the total number of books loaned out from
--that branch.
--[DONE]
SELECT COUNT(lb.BranchName) AS '# of Loans', lb.BranchName AS 'Library Branch'
FROM library_branch lb
INNER JOIN book_loans bl ON lb.BranchId=bl.BranchId
GROUP BY BranchName;

--6. Retrieve the names, addresses, and number of books checked out for all borrowers who have more
--than five books checked out.
--[DONE]
SELECT brw.Name, brw.Address, COUNT(bl.CardNo) AS '# Books Checked Out'
FROM borrower brw
INNER JOIN book_loans bl ON brw.CardNo=bl.CardNo
GROUP BY brw.Name, brw.Address;

--7. For each book authored (or co-authored) by "Stephen King", retrieve the title and the number of
--copies owned by the library branch whose name is "Central"
--[DONE]
SELECT b.Title AS 'Book Title', bc.NoOfCopies AS '# of Copies'
FROM book AS b
INNER JOIN book_copies AS bc ON b.BookId=bc.BookId
INNER JOIN book_authors AS ba ON bc.BookId=ba.BookId
INNER JOIN library_branch AS lb ON bc.BranchId=lb.BranchId
WHERE ba.AuthorName = 'Stephen King'
AND lb.BranchName = 'Central'
GROUP BY b.Title, bc.NoOfCopies;