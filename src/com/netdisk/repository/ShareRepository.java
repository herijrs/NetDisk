package com.netdisk.repository;


import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.netdisk.model.Share;

public interface ShareRepository extends JpaRepository<Share, Integer> {
	
	@Transactional
	@Modifying
	@Query(value="insert into share(user_id,sharelink,sharecode,filename,time) value(?1,?2,?3,?4,?5)",nativeQuery=true)
	int addlink(int user_id,String sharelink,String sharecode,String filename,String time);
	
	@Transactional
	@Modifying
	@Query(value="delete from share where sharelink=?1 and sharecode=?2",nativeQuery=true)
	int deletelink(String sharelink,String sharecode);
	
	@Query(value="select * from share where sharelink like ?1 ESCAPE '/' and sharecode=?2",nativeQuery=true)
	List<Share> findlink(String sharelink,String sharecode);
	
	@Query(value="select filename from share where sharelink like ?1 ESCAPE '/' and sharecode=?2",nativeQuery=true)
	String findname(String sharelink,String sharecode);
	
	@Query(value="select user_id from share where sharelink like ?1 ESCAPE '/' and sharecode=?2",nativeQuery=true)
	Integer finduser(String sharelink,String sharecode);
	

}
