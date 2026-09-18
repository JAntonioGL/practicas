export interface IRegistroPayload {
  name: string;
  email: string;
  password: string;
}

export interface ILoginPayload {
  email: string;
  password: string;
}

export interface IUsuarioDB {
  id: string; // o string, dependiendo de cómo lo tengas en Postgres
  nombre: string;
  correo: string;
  password_hash: string;
  google_uid: string | null; // null si a veces está vacío
  fcm_token: string | null;
  ultimo_login_en: Date
}

export interface IPushUsuarioDB {
  nombre: string,
  correo: string,
  password_hash: string,
  google_uid: string,
  fcm_token: string,
}

export interface IPayloadResTokenJWT {
  id: string,
  correo: string,
}