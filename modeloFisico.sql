drop table if exists processoDeMatricula;
drop table if exists matricula;	
drop table if exists horario;
drop table if exists preRequisito;
drop table if exists disciplina;
drop table if exists curso;
drop table if exists professor;
drop table if exists aluno;

#aluno(cpf, nome)
create table aluno (
	cpf bigint unsigned primary key,
    nome varchar(50),
    senha varchar(20)
);

#professor (*siape, nome)
create table professor (
	siape int unsigned primary key,
    nome varchar(50)
);

#curso(*codigo, nome)
create table curso (
	codigo smallint unsigned primary key,
    nome varchar(100)
);

#disciplina(*codigo, fase, CH, CHminima, **cursoCodigo, **professorSiape)
	#cursoCodigo referencia curso(codigo)
    #professorSiape referencia professor(siape)
create table disciplina (
	codigo char(4) primary key,
    fase tinyint unsigned,
    CH smallint unsigned,
    CHminima smallint unsigned,
    cursoCodigo smallint unsigned,
    professorSiape int unsigned,
    constraint fk_disciplina_cursoCodigo_curso_codigo foreign key (cursoCodigo) references curso(codigo),
    constraint fk_disciplina_professorSiape_disciplina_siape foreign key (professorSiape) references professor(siape)
);

#Pré-requisito(***disciplina, ***pre-requisito)
	#disciplina referencia disciplina(codigo)
    #pre-requisito referencia disciplina(codigo)
create table preRequisito (
	id mediumint unsigned auto_increment primary key,
    disciplina char(4),
    preRequisito char(4),
    constraint fk_preRequisito_disciplina_disciplina_codigo foreign key (disciplina) references disciplina(codigo),
    constraint fk_preRequisito_preRequisito_disciplina_codigo foreign key (preRequisito) references disciplina(codigo)
);

#horario (*turno, *num_aula, *num_aula, *semanaAB, ***codigo_disciplina, semestre)
	#codigo_disciplina referencia disciplina(codigo)
create table horario (
	id tinyint unsigned auto_increment primary key,
    turno tinyint unsigned,
    numAula tinyint unsigned,
    semanaAB tinyint unsigned,
    codigoDisciplina char(4),
    semestre smallint unsigned,
    constraint fk_horario_codigoDisciplina_disciplina_codigo foreign key (codigoDisciplina) references disciplina(codigo)
);

#matricula(***aluno, ***curso, *matricula)
	#aluno referencia aluno(cpf)
    #curso referencia curso(codigo)
create table matricula (
	id smallint unsigned auto_increment primary key,
    aluno bigint unsigned,
	curso smallint unsigned,
    matricula int unsigned,
    constraint fk_matricula_aluno_aluno_cpf foreign key (aluno) references aluno(cpf),
    constraint fk_matricula_aluno_curso_codigo foreign key (curso) references curso(codigo)
);

#processoDeMatricula(***matricula, ***disciplina, concluido, semestre)
	#matricula referencia matricula(aluno,curso)
    #disciplina referencia disciplina(codigo)
create table processoDeMatricula (
	id smallint unsigned auto_increment primary key,
    matricula smallint unsigned,
    disciplina char(4),
    concluido tinyint unsigned,
    semestre smallint unsigned,
    constraint fk_processoDeMatricula_matricula_matricula_id foreign key (matricula) references matricula(id),
    constraint fk_processoDeMatricula_disciplina_disciplina_codigo foreign key (disciplina) references disciplina(codigo)
);
    
