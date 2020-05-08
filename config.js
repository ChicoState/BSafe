const SENDMAIL_TRANSPORT = {
  sendmail: true,
  newline: 'unix',
  path: '/usr/sbin/sendmail',
};

const SMTP_TRANSPORT = {
  service: "Gmail",
  auth: {
    user: 'BsafeChico',
    pass: '',
  },
  secureConnection: 'false',
  tls: {
    ciphers: 'SSLv3',
  },
};
module.exports = {
  transport: SMTP_TRANSPORT,
  mailOptions: {
    from: '"BsafeChico" <BsafeChico@gmail.com>',
  },
  debugEnabled: false,
};
