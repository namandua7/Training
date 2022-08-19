CREATE DATABASE blog;
USE blog;
CREATE TABLE blog_categories (bc_category_id INT(10) NOT NULL AUTO_INCREMENT,
			bc_category_name VARCHAR(100) NOT NULL, bc_parent_id INT(11) NOT NULL,
            bc_category_status enum('Active', 'Inactive') NOT NULL DEFAULT 'Active',
            bc_date_added DATETIME NOT NULL, bc_created_by INT(11) NOT NULL,
            bc_date_modified TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
            bc_modified_by INT(11) DEFAULT NULL)

CREATE TABLE blog_details(bd_blog_id INT(11) NOT NULL AUTO_INCREMENT, bd_user_id INT(11)
			 NOT NULL, bd_category_id INT(11) NOT NULL, bd_blog_title VARCHAR(100)
             NOT NULL, bd_blog_description TEXT NOT NULL, bd_blog_status enum('Published',
             'Draft') NOT NULL DEFAULT 'PUBLISHED', bd_date_added DATETIME NOT NULL