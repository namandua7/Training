# 1. Write a query to find all the blog posts whose created date is greater/equal to given date.

SELECT bd_blog_id, bd_blog_title, bd_date_added
FROM blogs_details
WHERE bd_date_added >= 'YYYY-MM-DD HH:MM:SS';

# 2. Write a query to find all the blog posts whose create date is less than given date.

SELECT bd_blog_id, bd_blog_title, bd_date_added
FROM blogs_details
WHERE bd_date_added < 'YYYY-MM-DD HH:MM:SS';

# 3. Write a query to find all the blog posts whose created date between given start date & end date.

SELECT bd_blog_id, bd_blog_title, bd_date_added
FROM blogs_details
WHERE bd_date_added BETWEEN 'YYYY-MM-DD HH:MM:SS' AND 'YYYY-MM-DD HH:MM:SS';

# 4. Write a query to list all the comments on a particular blog.

SELECT *
FROM blogs_comments
WHERE bc_blog_id IN(SELECT bd_blog_id FROM blogs_details WHERE bd_blog_title='Another Ethical Hacking');

# 5. Write a query to transfer all the posts of a particular user to another user.

# 6. Write a query to get total published blogs

SELECT  COUNT(*)
FROM blogs_details
WHERE bd_blog_status = 'Published';

# 7. Write a query to update blog title of "8 SEO strategies to keep on radar in 2017" to 
#	 "8 SEO strategies to keep on radar in 2018"

UPDATE blogs_details
SET bd_blog_title = '8 SEO strategies to keep on radar in 2018'
WHERE bd_blog_title = '8 SEO strategies to keep on radar in 2017';

# 8. Write a query to get all active users

SELECT * 
FROM blogs_users
WHERE bu_status = 'Active';

# 9. Write a query to get all active categories

SELECT *
FROM blogs_categories
WHERE bc_category_status = 'Active';

# 10. Write a query to find all the blog posts for a particular user (i.e. based on username)

SELECT bu.bu_user_id, bu.bu_first_name, bd_blog_id, bd_blog_title
FROM blogs_details bd
RIGHT JOIN blogs_users bu ON bu.bu_user_id = bd.bd_user_id
WHERE bu.bu_last_name = 'Teotia';

# 11. Write a query to find the user details for a particular post

SELECT bd.bd_blog_id, bu.bu_user_id, bu.bu_first_name, bu.bu_last_name,
		bu.bu_email, bu.bu_password, bu.bu_status 
FROM blogs_users bu
RIGHT JOIN blogs_details bd ON bu.bu_user_id = bd.bd_user_id
WHERE bd_blog_id =6;

# 12. Write a query to delete all the posts of a particular user

DELETE FROM blogs_details bd
WHERE (SELECT * FROM blogs_users WHERE first_name='Arjun');

# 13. Write a query to find blog post & their corresponding comment count.

SELECT bd.bd_blog_id, COUNT(bc_blog_id)AS Comment_count
FROM blogs_comments bc
RIGHT JOIN blogs_details bd ON bc.bc_blog_id = bd.bd_blog_id
GROUP BY bc_blog_id
ORDER BY bd.bd_blog_id;

# 14. Write two query to get all published blogs modified by inactive users

SELECT * FROM blogs_details
WHERE bd_blog_status = 'Published' AND 
		bd_user_id IN (SELECT bu_user_id FROM blogs_users WHERE bu_status = 'Inactive');
        
# 15. Write a query to get most modifed blogs according to all users

# 16. Write a query to get draft blogs by inactive users

SELECT * FROM blogs_details bd
JOIN blogs_users bu ON bd.bd_user_id = bu.bu_user_id
WHERE bu.bu_status = 'Inactive' AND bd.bd_blog_status = 'Draft';

# 17. Write a query to find the blog post having the maximum comment count.

SELECT * FROM blogs_details
WHERE bd_blog_id = (SELECT MAX(total_comments) 
					FROM (SELECT COUNT(bc_blog_id)AS total_comments FROM blogs_comments GROUP BY bc_blog_id)
					AS max);

# 18. Write a query to get all active categories and their no of blogs

SELECT bc.bc_category_id, COUNT(bd_category_id) AS Total_blogs
FROM blogs_categories bc
LEFT JOIN blogs_details bd ON bc.bc_category_id = bd.bd_category_id
WHERE bc.bc_category_status = 'Active'
GROUP BY bd.bd_category_id;
 
# 19. Write a query to find out all the blog post of particular given sub category (Sub category name is given)

SELECT * FROM blogs_details
WHERE bd_category_id=(
SELECT bc_parent_id FROM blogs_categories
WHERE bc_category_id = 10
);
    
# 20. Write a query to find out all the blog post of particular given main category (category name is given)

SELECT * FROM blogs_details
WHERE bd_category_id IN(
SELECT bc_category_id FROM blogs_categories
WHERE bc_parent_id = 3
);