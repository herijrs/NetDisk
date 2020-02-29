package com.netdisk.repository;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.netdisk.model.Files;

public interface FileRepository extends JpaRepository<Files, Integer> {
	/* 遍历用户文件(层) */
	@Query(value="select * from file where user_id=?1 and fileparent=?2",nativeQuery=true)
	List<Files> findAllfile(Integer userid,String fileparent);
	
	/* 已用空间 */
	@Query(value="select sum(file_size) from file where user_id=?1",nativeQuery=true)
	int findsize(Integer userid);
	
	/* 判断是否存在同名文件 */
	@Query(value="select * from file where user_id=?1 and filename=?2 and file=?3 and fileparent=?4",nativeQuery=true)
	List<Files> findfile(Integer userid,String filename,String file,String fileparent);
	
	/* 查找文件夹内容 */
	@Query(value="select * from file where user_id=?1 and fileparent=?2",nativeQuery=true)
	List<Files> findfolder(Integer userid,String fileparent);
	
	/* 删除文件 */
	@Transactional
	@Modifying
	@Query(value="delete from file where id=?1",nativeQuery=true)
	int delfile(Integer id);
	
	/* 修改文件名 */
	@Transactional
	@Modifying
	@Query(value="update file set filename=?1 where id=?2",nativeQuery=true)
	int rename(String filename,Integer id);
	
	/* 修改文件路径 */
	@Transactional
	@Modifying
	@Query(value="update file set file=?1 where id=?2",nativeQuery=true)
	int repath(String file,Integer id);
	
	/* 上传文件 */
	@Transactional
	@Modifying
	@Query(value="insert into file(user_id,file,filename,time,file_size,fileparent,filetype) value(?1,?2,?3,?4,?5,?6,?7)",nativeQuery=true)
	int addfile(int user_id,String filepath,String filename,String time,long file_size,String fileparent,String filetype);
	
	/* 查询文件 */
	@Query(value="select * from file where user_id=?1 and filename like %?2%",nativeQuery=true)
	List<Files> searchfile(Integer id,String search);
	
	/* 查询文件地址 */
	@Query(value="select file from file where id=?1",nativeQuery=true)
	String findpath(Integer id);
	
	/* 查询文件名称 */
	@Query(value="select filename from file where id=?1",nativeQuery=true)
	String findname(Integer id);
	
	/* 查询文件所属文件夹 */
	@Query(value="select fileparent from file where user_id=?1 and id=?2",nativeQuery=true)
	String findparent(Integer user_id,Integer id);
	
	/* 查询文件夹下文件*/
	@Query(value="select * from file where user_id=?1 and file like ?2% ESCAPE '/'",nativeQuery=true)
	List<Files> findchild(Integer id,String file);
	
	/* 按类型查询文件 */
	@Query(value="select * from file where user_id=?1 and filetype like ?2% ",nativeQuery=true)
	List<Files> findfilebytype(Integer id,String filetype);
	
	/* 查询文件类型 */
	@Query(value="select filetype from file where filename =?1",nativeQuery=true)
	String findtypebyname(String filename);

}
