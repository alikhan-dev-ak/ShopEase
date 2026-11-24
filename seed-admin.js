require('dotenv').config();const mysql=require('mysql2/promise'),bcrypt=require('bcryptjs');
(async()=>{const db=await mysql.createConnection({host:process.env.DB_HOST||'localhost',user:process.env.DB_USER||'root',password:process.env.DB_PASSWORD||'',database:process.env.DB_NAME||'online_shop'});
const email=process.argv[2]||'admin@example.com',pass=process.argv[3]||'Admin12345!',hash=await bcrypt.hash(pass,12);
await db.execute("INSERT INTO users(name,email,password_hash,role) VALUES('Store Administrator',?,?, 'admin') ON DUPLICATE KEY UPDATE password_hash=VALUES(password_hash),role='admin'",[email,hash]);
console.log('Admin:',email,' Password:',pass,' (change after demo)');await db.end()})().catch(e=>{console.error(e);process.exit(1)});
