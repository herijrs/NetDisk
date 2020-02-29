package com.netdisk.repository;


import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.netdisk.model.Disk;

@Repository
public interface DiskRepository extends JpaRepository<Disk, Integer> {
	@Transactional
	@Modifying
	@Query(value="insert into diskinfo(disk_userid,total_size,used_size) value(?1,?2,?3)",nativeQuery=true)
	int adddisk(int disk_userid,int total_size,int used_size);
	
	@Query(value="select * from diskinfo where disk_userid=:disk_userid",nativeQuery=true)
	Disk finddisk(@Param("disk_userid")int disk_userid);
	
	@Transactional
	@Modifying
	@Query(value="update diskinfo set used_size=?1 where disk_userid=?2",nativeQuery=true)
	int updatedisk(int used_size,Integer id);
	
	@Query(value="select * from diskinfo ",nativeQuery=true)
	List<Disk> findalldisk();
	
	@Query(value="select id from diskinfo where disk_userid=?1",nativeQuery=true)
	Integer finddisk_id(Integer disk_userid);


}
