package com.netdisk.repository;


import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.ResponseBody;

import com.netdisk.model.User;
@Repository
public interface UsersRepository extends JpaRepository<User, Integer> {
	@Transactional
	@Modifying
	@Query(value="insert into users(userName,password,email,regTime,disk_id) values(?1,?2,?3,?4)",nativeQuery=true)
	int addUser(String userName,String password,String email,String RegTime);
	
	@Query(value="select * from users where userName=?1 and password=?2",nativeQuery=true)
	User findUser(String userName,String password);
	
	@Query(value="select max(id) from users",nativeQuery=true)
	Integer findid();
	 
	@Transactional
	@Modifying
	@Query(value="update users set userName=?1,password=?2,email=?3 where userName =?3",nativeQuery=true)
	int updateUser(String userName,String password,String email,String username);
	
	@Query(value="select * from users where userName=?1",nativeQuery=true)
	User findbyname(String userName);
	
	@Query(value="select * from users",nativeQuery=true)
	List<User> findalluser();
	
	//找回密码
	@Query(value="select password from users where userName=?1 and email =?2",nativeQuery=true)
	String findpass(String userName,String email);
	
	@Query(value="select userName from users where id=?1",nativeQuery=true)
	String findname(int id);
}
