dataSource {
    pooled = true
    driverClassName = "com.mysql.jdbc.Driver"
    dialect = "org.hibernate.dialect.MySQL5InnoDBDialect"
}
hibernate {
    cache.use_second_level_cache = true
    cache.use_query_cache = false
//    cache.region.factory_class = 'net.sf.ehcache.hibernate.EhCacheRegionFactory' // Hibernate 3
    cache.region.factory_class = 'org.hibernate.cache.ehcache.EhCacheRegionFactory' // Hibernate 4
    singleSession = true // configure OSIV singleSession mode
    flush.mode = 'manual' // OSIV session flush mode outside of transactional context
}

// environment specific settings
environments {
    development {
        dataSource {
            dbCreate = "update" // one of 'create', 'create-drop','update'
            url = "jdbc:mysql://localhost/arazu2?useUnicode=yes&characterEncoding=UTF-8"
            username = "root"
            password = "mysql"
        }

    }
    test {
        dataSource {
            dbCreate = "update"
            url = "jdbc:h2:mem:testDb;MVCC=TRUE;LOCK_TIMEOUT=10000;DB_CLOSE_ON_EXIT=FALSE"
        }
    }
    production {
        dataSource {
            dbCreate = "update" // one of 'create', 'create-drop','update'
            url = "jdbc:mysql://192.168.1.132/esicc?useUnicode=yes&characterEncoding=UTF-8"
            username = "root"
            password = "mysql"
        }
    }
}

////////////////////////////////////// POSTGRES ////////////////////////////////////////////
//dataSource {
//    pooled = true
//    driverClassName = "org.postgresql.Driver"
//    dialect = org.hibernate.dialect.PostgreSQLDialect
//}
//hibernate {
//    cache.use_second_level_cache = true
//    cache.use_query_cache = true
//    cache.provider_class = 'net.sf.ehcache.hibernate.EhCacheProvider'
//}
//// environment specific settings
//environments {
//    development {
//        dataSource {
//            dbCreate = "update"
//            url = "jdbc:postgresql://192.168.1.143:5432/arazu2"
////            url = "jdbc:postgresql://localhost:5432/arazu2"
//            username = "postgres"
//            password = "postgres"
//        }
//    }
//    test {
//        dataSource {
//            dbCreate = "update"
//            url = "jdbc:postgresql://10.0.0.3:5432/happy"
//            username = "postgres"
//            password = "postgres"
//        }
//    }
//    production {
//        dataSource {
//            dbCreate = "update"
//            url = "jdbc:postgresql://127.0.0.1:5432/happy"
//            username = "postgres"
//            password = "janus"
//        }
//    }
//}
