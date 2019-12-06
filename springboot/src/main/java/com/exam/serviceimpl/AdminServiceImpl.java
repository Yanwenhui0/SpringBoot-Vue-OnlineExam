package com.exam.serviceimpl;

import com.exam.entity.Admin;
import com.exam.mapper.AdminMapper;
import com.exam.service.AdminService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AdminServiceImpl implements AdminService {

    @Autowired
    private AdminMapper adminMapper;

    @Override
    public List<Admin> findAll() {
        return adminMapper.findAll();
    }

    @Override
    public Admin findById(Integer adminId) {
        return adminMapper.findById(adminId);
    }

    @Override
    public int deleteById(int adminId) {
        return adminMapper.deleteById(adminId);
    }

    @Override
    public int update(Admin admin) {
        return adminMapper.update(admin);
    }

    @Override
    public int add(Admin admin) {
        return 0;
    }

    @Override
    public Integer updatePassword(String adminId, String oldPassword, String password) {
        Admin admin = validPassword(adminId, oldPassword);
        if(null == admin) {
            return null;
        }
        admin.setPwd(password);
        return adminMapper.updateById(admin);
    }

    private Admin validPassword(String adminId, String password) {
        Admin byId = adminMapper.findById(Integer.valueOf(adminId));
        if(StringUtils.equals(password, byId.getPwd())) {
            return byId;
        }
        return null;
    }
}
