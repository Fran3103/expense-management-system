CREATE TABLE expense_requests (
   id BIGSERIAL PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    description TEXT NOT NULL,
    amount NUMERIC(10,2) NOT NULL CHECK (amount >= 0),
    status VARCHAR(20) NOT NULL DEFAULT 'DRAFT',
    comment TEXT,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    due_date DATE,
    created_by BIGINT NOT NULL,
    category_id BIGINT NOT NULL,
    CONSTRAINT fk_expense_requests_user
     FOREIGN KEY (created_by) REFERENCES users(id),
    CONSTRAINT fk_expense_requests_category
     FOREIGN KEY (category_id) REFERENCES expense_categories(id)
);

CREATE TABLE approval_history (
 id BIGSERIAL PRIMARY KEY,
 expense_request_id BIGINT NOT NULL,
 acted_by BIGINT NOT NULL,
 action VARCHAR(20) NOT NULL,
 comment TEXT,
 created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 CONSTRAINT fk_approval_history_expense_request
    FOREIGN KEY (expense_request_id) REFERENCES expense_requests(id),
 CONSTRAINT fk_approval_history_user
    FOREIGN KEY (acted_by) REFERENCES users(id)
);