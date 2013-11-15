package th.co.imake.syndome.bpm.backoffice.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import th.co.imake.syndome.bpm.backoffice.domain.User;

public interface UserRepository extends JpaRepository<User,Long> {
//public interface UserRepository extends JpaRepository<UserContact, Long> {
	
	User findByUsername(String username);
	//UserContact findByUsername(String username);
}
